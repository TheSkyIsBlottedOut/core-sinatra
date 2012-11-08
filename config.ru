require './core'
map(?/+Sinatra::Sprockets.config.prefix) do
  run Sinatra::Sprockets.environment {|env| env.logger = Logger.new(STDOUT)}
end
map(?/) { run Application }
