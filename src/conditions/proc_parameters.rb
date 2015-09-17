class ProcParameters
  def filter(parameters, quantity, rule)
    parameters.select { |parameter| rule.call parameter }.size.equal? quantity
  end
end