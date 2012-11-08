class Symbol
  def ~@
    _bound = binding
    return ->(arg) {_bound.send(self, arg)}
  end
end