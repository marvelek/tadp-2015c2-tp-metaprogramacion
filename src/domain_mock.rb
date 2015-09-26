module TestModule

  def super_crazy_method(p2)
    "This is by far a #{p2} method"
  end

end

class TestClass

  def crazy_method(p1)
    "This is a #{p1} method"
  end

  def crazy_long_method(p1, a1, var, var1, lorem2, ipsum2, var6, var9)
    "This is a #{p1} method"
  end

end

class TestClassRedirected

  def crazy_method(p1)
    "This is a redirected #{p1} method"
  end

  def crazy_long_method(p1, a1, var, var1, lorem2, ipsum2, var6, var9)
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
  def method_1param(param1)
  end
  def method_2params(param1,param2)
  end
  def method_1opt(param1 = nil)
  end
  def method_2opt(param1 = nil, param2 = nil)
  end
  def method_1man_1opt(param1, param2 = nil)
  end
  def method_3man(param1, param2, param3)
  end
  def method_2man_1opt(param1, param2, param3 = nil)
  end
  def method_1man_2opt(param1, param2 = nil, param3 = nil)
  end
  def method_3opt(param1 = nil, param2 = nil, param3 = nil)
  end
  def method_2man_2opt(param1, param2, param3 = nil, param4 = nil)
  end
end
class Dummy_class2
  def saludar(x)
    "Hola, " + x
  end
  def method_1arg_with_m(arg1,arg_with_m)
  end
  def method_with_no_m(arg1,arg2)
  end
  def method_with_param(parameter1,parameter2)
  end
end

class Dummy_class22
  def dat_method
  end

  private
  def bar
  end
end

class Dummy_class3
  def saludar(x)
    "Adiosin, " + x
  end
end
class Dummy_class4
end
class Dummy_class_mixin2
  extend Dummy_mixin2
end

class MiClase
  def hace_algo(p1, p2)
    p1 + '-' + p2
  end

  def hace_otra_cosa(p2, ppp)
    p2 + ':' + ppp
  end
end

class Mi_clase
  def m1(x,y)
    false
  end
end
