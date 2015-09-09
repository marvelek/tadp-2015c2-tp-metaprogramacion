require_relative '../src/condition'
require_relative '../src/transformer'

module AbstractAspectable
  #This Module should not be included/extended. Use AspectableObject for instances or AspectableModule for Modules or Classes
  include Transformer
  include Condition

  def where (*conditions)
    get_aspectable_methods.select do |method_symbol|
        method = get_aspectable_method(method_symbol)
        conditions.all? do |condition|
          condition.call(method)
        end
    end
  end

  def transform (filtered_methods, &block)
    filtered_methods.each do |method_symbol|
      method = get_aspectable_method(method_symbol)
      block.call.call(method) #First call executes the transform block. Second call is for the actual transformer
    end
  end

end

module AspectableModule
  include AbstractAspectable

  def get_aspectable_methods
    instance_methods
  end

  def get_aspectable_method(method_symbol)
    instance_method(method_symbol)
  end

  def define_aspectable_method(symbol, &block)
    define_method symbol, &block
  end

end

module AspectableObject
  include AbstractAspectable

  def get_aspectable_methods
    singleton_class.instance_methods
  end

  def get_aspectable_method(method_symbol)
    singleton_class.instance_method(method_symbol)
  end

  def define_aspectable_method(symbol, &block)
    define_singleton_method symbol, &block
  end

end
