module Name

  def name(regex)
    proc { |method|
      regex.match(method.name) }
  end

end