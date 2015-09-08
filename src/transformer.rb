module Transformer

  def print_name(param)
    proc { |a_method| print "#{a_method} #{param}" }
  end

  def create_method()
    proc { define_aspectable_method(:sarasa) do
      print "This is a created method!! "
    end }
  end

end

