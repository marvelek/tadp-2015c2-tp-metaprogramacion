require_relative '../../src/transformers/transformer'

module Redirect

  include Transformer

  def redirect_to(substitute)
    @methods.each do |method, owner|
      unless substitute.is_a? method.owner
        owner.send :define_method, method.name do |*args|
          substitute.send(method.name, *args)
        end
      end
    end

    update_methods

  end
end