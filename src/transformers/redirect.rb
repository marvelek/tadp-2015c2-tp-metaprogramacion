module Redirect

  def redirect_to(replacer_class)
    @methods.each do |method| method.owner.define_singleton_method(:method) do |*args| replacer_class.method args
      end
    end
  end
end