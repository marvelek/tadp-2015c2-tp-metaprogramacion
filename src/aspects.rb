require_relative '../src/origin'
class Aspects

  def self.on(*origins, &block)
    origin = Origin.new
    origins.each do |an_origin|
      if an_origin.is_a? Class
        origin.add_class(an_origin)
      elsif an_origin.is_a? Module
        origin.add_module(an_origin)
      else
        origin.add_objects(an_origin)
      end
    end

    origin.instance_eval(&block)

  end
end