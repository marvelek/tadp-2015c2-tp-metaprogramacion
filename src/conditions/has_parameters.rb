require_relative 'regexp_parameters'
module Has_parameters

  def has_parameters(quantity, rule = nil)
    proc { |method|
      klass_name = "#{rule.class}Parameters"
      klass = const_get(klass_name) if const_defined?(klass_name)
      klass ||= QuantityParameter
      klass.new.filter(method.parameters,quantity,rule)
    }
  end

end