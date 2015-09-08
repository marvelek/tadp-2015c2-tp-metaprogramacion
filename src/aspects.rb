require_relative '../src/exceptions/empty_arguments'
require_relative '../src/exceptions/empty_origins'
require_relative '../src/aspectable'
class Aspects

  def self.on(*origins, &block)
    raise EmptyArgumentsException.new unless
    sources = get_sources(origins)
    sources.each do |source|
      source.is_a? Module ? source.send(:include, AspectableModule) : source.extend(AspectableObject)
      source.instance_eval(&block)
    end
  end

  def self.get_sources(origins)
    results_sources = []
    origins.each do |origin|
      origin.class.is_a? Regexp ? results_sources.push get_sources_from_regexp(origin) : results_sources.push origin
    end
    if results_sources.empty?
      raise EmptyOriginsException.new
    end
    results_sources.flatten!
    results_sources.uniq!
  end

  def self.get_sources_from_regexp(regexp)
    matching_sources = []
    Object.constants.select do | class_symbol |
      class_symbol.grep(regexp)
    end
    .each do | symbol |
      matching_sources.push Object.const_get(symbol)
    end
    matching_sources
  end
end