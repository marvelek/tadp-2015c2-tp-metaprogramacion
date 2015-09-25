module Inject_logic
  def before(&proc)
    @methods.each do |method|
      original_method = method
      method.owner.send :define_method, method.name do |*args|
        proc.call method.owner,original_method,*args
        original_method.bind(self).call *args
      end
    end
  end

  def after(&proc)
    @methods.each do |method|
      original_method = method
      method.owner.send :define_method, method.name do |*args|
        original_method.bind(self).call *args
        proc.call method.owner,original_method,*args
      end
    end
  end

  def instead_of(&proc)
    @methods.each do |method|
      original_method = method
      method.owner.send :define_method, method.name do |*args|
        proc.call method.owner,original_method,*args
      end
    end
  end

end