module Has_parameters_name

  def self.evaluate(*parameters,arity,a_rule)
    parameters.grep(a_rule).size >= arity
  end
end