class NonMatchingOriginException < RuntimeError
  def initialize
    super('The regular expression does not match any Module or Class')
  end
end