require_relative '../src/exceptions/empty_origins'
require_relative '../src/exceptions/non_matching_origin'
require_relative '../src/aspectable'
class Aspects

  def self.on(*origins, &block)
    raise EmptyOriginsException if origins.empty?
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
    raise NonMatchingOriginException if sources.empty?
    sources.uniq
  end

  def self.get_sources_from_regexp(regexp)
    Object.constants.grep(regexp).flat_map do |sym| Object.const_get(sym) end
  end

end