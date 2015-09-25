module TestModule

  def super_crazy_method(p2)
    "This is by far a #{p2} method"
  end

end

class TestClass

  def crazy_method(p1)
    "This is a #{p1} method"
  end


end

module CompleteTestModule

  def crazy_method(p1)
    "This is a #{p1} method"
  end

  def super_crazy_method(p2)
    "This is by far a #{p2} method"
  end

end

class CompleteTestClass

  def crazy_method(p1)
    "This is a #{p1} method"
  end

  def super_crazy_method(p2)
    "This is by far a #{p2} method"
  end

end

module Dummy_mixin1
end
module Dummy_mixin3
end
module Dummy_mixin2
end
class Dummy_class1
end
class Dummy_class2
  def dat_method
  end

  private
  def bar
  end

end
class Dummy_class3
end
class Dummy_class4
end
class Dummy_class_mixin2
  extend Dummy_mixin2
end
