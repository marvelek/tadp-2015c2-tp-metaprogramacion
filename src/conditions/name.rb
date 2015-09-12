module Name

  def name(regex)
    @methods.select do |method|
      regex.match(method.name)
    end
  end

end