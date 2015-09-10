module Condition

  def name(regex)
    proc { |method| regex.match(method) }
  end

end