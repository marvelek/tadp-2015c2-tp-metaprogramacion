module Condition

  def name(regex)
    proc { |a_method| regex.match(a_method) }
  end

end