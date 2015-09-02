require_relative '../src/condition'
require_relative '../src/transformer'

class Origin

  include Transformer
  include Condition
  attr_accessor :classes, :modules, :objects

  def initialize
    self.classes = []
    self.modules = []
    self.objects = []
  end

  def add_class (a_class)
    classes.push(a_class)
  end

  def add_module (a_module)
    modules.push(a_module)
  end

  def add_objects (an_object)
    objects.push(an_object)
  end

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
    @methods = get_methods_symbols
    where_proc.call(@methods).each do |a_method|
      block.call.call(a_method) #First call executes the transform block. Second call is for the actual transformer
    end
  end

  def get_methods_symbols
    classes.flat_map { |a_class| a_class.instance_methods } + modules.flat_map { |a_module| a_module.instance_methods } + objects.flat_map { |an_object| an_object.methods }
  end

end