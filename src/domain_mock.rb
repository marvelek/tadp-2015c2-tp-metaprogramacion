module TestModule

  def super_crazy_method
    print 'This is a by far a crazier method'
  end

end

class TestClass

  def crazy_method
    print 'This is a crazy method'
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
end
class Dummy_class3
end
class Dummy_class4
end
class Dummy_class_mixin2
  extend Dummy_mixin2
end