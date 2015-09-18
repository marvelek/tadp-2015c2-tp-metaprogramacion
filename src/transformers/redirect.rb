module Redirect
  def redirect_to(substitute)
    @methods.each do |method|
      method.owner.send :define_method, method.name do |*args| substitute.send(method.name, *args) end
    end
  end
end