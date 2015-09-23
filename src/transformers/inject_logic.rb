module Inject_logic
  def before(&proc)
    @methods.each do |method|
      method.owner.send :define_method method.name do |*args|
        proc.call *args
        method.bind(self).call
      end
    end
  end
end