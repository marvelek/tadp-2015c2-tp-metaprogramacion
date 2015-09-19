module Inject

  def inject(hash)
    raise ArgumentError.new 'empty hash' if hash.empty?
    @methods.each do |original_method|
      parameters_list = original_method.parameters.flat_map(&:last)
      define_injected_method hash, original_method, parameters_list
    end
  end

  def define_injected_method(hash, original_method, parameters_list)

    original_method.owner.send :define_method, original_method.name do |*original_args|

      param_args = parameters_list.zip(original_args).each do |original_param_arg|
        hash.each do |param, arg|
          if original_param_arg.first.equal? param
            original_param_arg[1] = arg.is_a?(Proc) ? arg.call(self, original_method, original_param_arg.last) : arg
          end
        end
      end

      args = param_args.flat_map(&:last)
      original_method.bind(self).call *args

    end

  end

end

