module Neg
  def neg(*conditions)
    proc {|target_origin,method| conditions.none? {|condition| condition.call(target_origin,method)}}
  end
end