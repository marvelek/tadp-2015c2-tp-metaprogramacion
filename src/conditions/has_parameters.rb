require_relative 'has_parameters_name'
module Has_parameters

  def has_parameters(arity, a_rule = nil)
    proc { |a_method| a_rule.is_a?(Regexp) ? Has_parameters_name.evaluate(a_method.parameters, arity, a_rule) : false }
  end

end