require_relative '../src/condition'
require_relative '../src/transformer'

module AbstractAspectable
  #This Module should not be included/extended. Use AspectableObject for instances or AspectableModule for Modules or Classes
  include Transformer
  include Condition

  def where (*conditions)
    proc { |methods_array|
      methods_array.select do |a_method|
        conditions.all? do |a_condition|
          a_condition.call(a_method)
        end
      end
    }
  end

  def transform (where_proc, &block)
    where_proc.call(get_aspectable_methods).each do |a_method|
      block.call.call(a_method) #First call executes the transform block. Second call is for the actual transformer
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
    methods
  end

  def get_aspectable_method(method_symbol)
    method(method_symbol)
  end

  def define_aspectable_method(symbol, &block)
    define_singleton_method symbol, &block
  end

end