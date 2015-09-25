require_relative '../src/exceptions/empty_origins'
require_relative '../src/exceptions/non_matching_origin'
require_relative '../src/conditions/name'
require_relative '../src/transformers/inject'
require_relative '../src/conditions/visibility'
require_relative '../src/conditions/neg'

module Aspects

  extend Name
  extend Inject
  extend Visibility
  extend Neg

 attr_accessor :target_origin

  def self.on(*origins, &block)
    raise EmptyOriginsException if origins.empty?
    @methods = get_methods(get_sources origins)
    instance_eval &block
  end

  def self.where (*conditions)
    @methods.select do |method|
      conditions.all? do |condition|
        condition.call( @@target_origin,method)
      end
    end
  end

  def self.transform(methods, &transformations)
    @methods = methods
    instance_eval &transformations
  end

  def self.get_sources(origins)
    sources = origins.flat_map do |origin|
      origin.is_a?(Regexp) ? get_sources_from_regexp(origin) : origin
    end
    raise NonMatchingOriginException if sources.empty?
    sources.uniq
  end

  def self.get_sources_from_regexp(regexp)
    Object.constants.grep(regexp).flat_map do |symbol|
      Object.const_get(symbol)
    end
  end

  def self.get_methods(sources)
    sources.flat_map do |origin|
      if origin.is_a?(Module) then
        get_methods_from_class_or_module(origin)
       @@target_origin = origin
      else
        get_methods_from_class_or_module(origin.singleton_class)
        @@target_origin = origin.singleton_class
      end
    end
  end

  def self.get_methods_from_class_or_module(origin)
    origin.instance_methods.flat_map do |symbol|
      origin.instance_method(symbol)
    end
  end

end