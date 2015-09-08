class EmptyOriginsException < RuntimeError
  def initialize
    super('origen vacio')
  end
end