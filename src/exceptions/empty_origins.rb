class EmptyOriginsException < RuntimeError
  def initialize
    super('Empty Origin list')
  end
end