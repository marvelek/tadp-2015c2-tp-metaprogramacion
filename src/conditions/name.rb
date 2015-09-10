module Name
  def name(regex)
    proc { |a_method| regex.match(a_method.to_s) }
  end
end