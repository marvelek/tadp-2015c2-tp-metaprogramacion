require_relative '../src/exceptions/empty_origins'
require_relative '../src/exceptions/non_matching_origin'
require_relative '../src/aspectable'
class Aspects

  def self.on(*origins, &block)
    raise EmptyOriginsException unless !origins.empty?
    sources = get_sources(origins)
    sources.each do |source|
      source.is_a?(Module) ? source.extend(AspectableModule) : source.extend(AspectableObject)
      source.instance_eval(&block)
    end
  end

  def self.get_sources(origins)
    sources = origins.flat_map do |origin|
      origin.is_a?(Regexp) ? get_sources_from_regexp(origin) : origin
    end
    sources.uniq!
    raise NonMatchingOriginException unless !sources.empty?
    sources
  end

  def self.get_sources_from_regexp(regexp)
    matching_sources = []
    Object.constants.select do |class_symbol|
      regexp.match(class_symbol)
    end
        .each do |symbol|
      matching_sources.push Object.const_get(symbol)
    end
    matching_sources
  end
end