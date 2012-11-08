=begin
  Just raise SCore::Exceptions::Whatever, "This is all your fault"
=end
module Exceptions
  class DefaultError < StandardError; end
  module ExceptionNamespace
    def const_missing(k)
      const_set(k, Class.new(::SCore::Exceptions::DefaultError))
    end
  end

  self.extend ExceptionNamespace
end