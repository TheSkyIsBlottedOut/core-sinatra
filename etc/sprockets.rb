Sinatra::Sprockets.configure do |config|
  config.app            = ::Application
  config.debug          = SCore.env?('development')
  config.compile        = true
  config.compress       = true
  config.digest         = false
  config.host           = nil # do stuff
  config.manifest_path  = SCore::Config.settings.assets.manifest
  config.paths          = %w{js css images}
  config.precompile     = SCore::Config.settings.assets.precompile
  config.prefix         = 'assets'
  config.css_compressor = false
  config.js_compressor  = false
  config
end