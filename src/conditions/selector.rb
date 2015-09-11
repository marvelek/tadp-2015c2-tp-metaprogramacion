module Selector

  def selector(regex)
    proc { |method| regex.match(method.name) }
  end

end