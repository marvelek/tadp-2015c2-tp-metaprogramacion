module Has_parameters

  def has_parameters(quantity, rule = nil)
    proc { |method|
      klass_name = "#{rule.class}Parameters"
      klass = const_get(klass_name) if const_defined?(klass_name)
      klass ||= QuantityParameters
      klass.new.filter(method.parameters,quantity,rule)
    }
  end

  def mandatory
    proc { |parameter| parameter.first.equal?(:req) }
  end

  def optional
    proc { |parameter| parameter.first.equal?(:opt) }
  end
end


class RegexpParameters

  def filter(parameters,quantity,regex)
    parameters.map{|arg| arg[1].to_s}.grep(regex).size == quantity
  end

end

class QuantityParameters
  def filter(parameters,quantity,rule=nil)
    parameters.size.equal?(quantity)
  end
end

class ProcParameters
  def filter(parameters, quantity, rule)
    parameters.select { |parameter| rule.call parameter }.size.equal? quantity
  end
end