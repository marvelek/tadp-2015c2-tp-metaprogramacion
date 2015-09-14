class RegexpParameters

  def filter(parameters,quantity,regex)
    parameters.map{|arg| arg[1].to_s}.grep(regex).size == quantity
  end

end