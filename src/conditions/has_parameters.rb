require_relative '../../src/conditions/quantity_parameters'
require_relative '../../src/conditions/regexp_parameters'
require_relative '../../src/conditions/proc_parameters'

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