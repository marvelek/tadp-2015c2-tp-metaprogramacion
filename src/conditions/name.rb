module Name

  def name(regex)
    proc { |_,method|
      regex.match(method.name) }
  end

end