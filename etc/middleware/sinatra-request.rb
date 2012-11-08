module Sinatra
  class Request
    def hostname
      "#{scheme}://#{host_with_port}/"
    end
  end
end