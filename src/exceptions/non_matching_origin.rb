class NonMatchingOriginException < RuntimeError
  def initialize
    super('Empty Origin list')
  end
end