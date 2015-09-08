require_relative '../src/aspectable'
class Aspects

  def self.on(*origins, &block)

    #processed_origins = foo(origins)
    processed_origins = origins

    processed_origins.each do |origin|
      if origin.is_a? Module
        origin.extend(AspectableModule)
      else
        origin.extend(AspectableObject)
      end
      origin.instance_eval(&block)
    end
  end
end