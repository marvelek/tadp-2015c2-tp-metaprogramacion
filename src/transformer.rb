module Transformer

  def inject(hash = {})
    proc { |method|
      param_list = method.parameters.flat_map do |param|
        param[1]
      end

      hash_array = hash.to_a

      define_aspectable_method(method.name) do |*parameters|
        args = param_list.zip(parameters).each do |param_tuple|
          hash_array.each do |hash_tuple|
            if param_tuple[0] == hash_tuple[0]
              param_tuple[1] = hash_tuple[1]
            end
          end
        end

        args_values = args.flat_map do |tuple|
          tuple[1]
        end

        method.bind(self).call(*args_values)
      end
    }
  end
end


