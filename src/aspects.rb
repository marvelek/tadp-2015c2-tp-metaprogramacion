require_relative '../src/exceptions/empty_origins'
require_relative '../src/exceptions/non_matching_origin'
require_relative '../src/conditions/name'
require_relative '../src/conditions/has_parameters'
require_relative '../src/transformers/inject'
require_relative '../src/transformers/redirect'
require_relative '../src/transformers/inject_logic'

module Aspects

  extend Has_parameters
  extend Name
  extend Inject
  extend Redirect
  extend Inject_logic

  def self.on(*origins, &block)
    raise EmptyOriginsException if origins.empty?
    @methods = get_methods(get_sources origins)
    @methods = Hash[*@methods]
    instance_eval &block
  end

  def self.where (*conditions)
    @methods.select do |method, origin|
      conditions.all? do |condition|
        condition.call method
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
      origin.is_a?(Module) ? get_methods_from_class_or_module(origin) : get_methods_from_class_or_module(origin.singleton_class)
    end
  end

  def self.get_methods_from_class_or_module(origin)
    all_methods = origin.instance_methods + origin.private_instance_methods
    all_methods.flat_map do |symbol|
      [origin.instance_method(symbol), origin]
    end

  end

end