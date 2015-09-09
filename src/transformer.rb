module Transformer

  def inject(hash = {})
    proc { |method|
      param_list = flat_map_second(method.parameters) #This gets the parameters names as a list (array)

      define_aspectable_method(method.name) do |*parameters|
        #Combine the parameter names with the values given by the user using zip
        args = param_list.zip(parameters).each do |param_tuple|
          hash.each do |key, value|
            #Updates the values of the array where an inject was applied
            update_param_value(key, value, param_tuple)
          end
        end

        #Executes the original method with the array as args
        method.bind(self).call(*flat_map_second(args))
      end
    }
  end

  private def update_param_value(key, value, param_tuple)
    if param_tuple[0].equal? key
      param_tuple[1] = value
    end
  end

  private def flat_map_second(array_of_array)
    array_of_array.flat_map do |array|
      array[1]
    end
  end
end


