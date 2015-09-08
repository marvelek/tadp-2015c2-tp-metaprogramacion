module Condition

  def namely(regex)
    proc { |a_method| regex.match(a_method) }
  end

end