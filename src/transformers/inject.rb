module InjectInstanceMethods

  def flat_map_second(array)
    array.flat_map do |elem|
      elem[1]
    end
  end

  def replace_args(hash, original_method, parameters_list, original_args)
    parameters_list.zip(original_args).each do |original_param_arg|
      hash.each do |param, arg|
        update_param_arg param, arg, original_param_arg, original_method
      end
    end
  end

  def update_param_arg(param, arg, original_param_arg, method)
    if original_param_arg.first.equal? param
      original_param_arg[1] = arg.is_a?(Proc) ? call_proc(arg, method, original_param_arg[1]) : arg
    end
  end

  def call_proc(arg, method, old_value)
    arg.call self, method.name, old_value
  end

end



module Inject
  include InjectInstanceMethods

  def inject(hash)
    raise ArgumentError.new 'empty hash' if hash.empty?
    add_to_transformer_command(create_inject_proc hash)
  end

  def create_inject_proc(hash)
    proc { |original_method|
      parameters_list = flat_map_second original_method.parameters
      define_injected_method hash, original_method, parameters_list
    }
  end

  def define_injected_method(hash, original_method, parameters_list)
    define_aspectable_method original_method.name do |*original_args|
      extend InjectInstanceMethods
      param_args = replace_args(hash, original_method, parameters_list, original_args)

      args = flat_map_second param_args

      original_method.bind(self).call *args
    end
  end

end

