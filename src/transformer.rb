module Transformer

  def print_name(param)
    proc { |a_method| print "#{a_method} #{param}" }
  end

end

