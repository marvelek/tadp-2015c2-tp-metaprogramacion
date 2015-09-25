module Transformer

  def update_methods
    @methods = Hash[*@methods.flat_map do |method, owner|
      [owner.instance_method(method.name) , owner]
    end]
  end

end