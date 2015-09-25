require_relative '../../src/transformers/transformer'

module Inject_logic
  include Transformer
  def before(&proc)
    @methods.each do |method,origin|
      original_method = method
      origin.send :define_method, method.name do |*args|
        proc.call origin,original_method,*args
        original_method.bind(self).call *args
      end
    end
    update_methods
  end

  def after(&proc)
    @methods.each do |method,origin|
      original_method = method
      origin.send :define_method, method.name do |*args|
        original_method.bind(self).call *args
        proc.call origin,original_method,*args
      end
    end
    update_methods
  end

  def instead_of(&proc)
    @methods.each do |method,origin|
      original_method = method
      origin.send :define_method, method.name do |*args|
        proc.call origin,original_method,*args
      end
    end
    update_methods
  end

end