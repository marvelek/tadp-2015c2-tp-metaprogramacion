module Visibility
  def is_public
    proc {|target,method| target.public_instance_methods.include?(method)}
  end

  def is_private
    proc { |target, method| target.private_instance_methods.include?(method) }
  end
end