module Inject
  def inject(hash = {})
    add_to_transformer_command(
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
        })
  end

  def sarasa()
    add_to_transformer_command(
        proc { |method| puts "THE SHELL OF THE PARROT LADY! #{method.name}" }
    )
  end
end