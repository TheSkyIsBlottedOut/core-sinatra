class Application < Sinatra::Base
  require     SCore.file('/etc/sprockets')
  enable      :sessions
  extend      SCore::AppLoader
  register    Sinatra::Sprockets
  register    Gon::Sinatra

  set :root,              SCore.root
  set :reload_templates,  SCore.env?('development')
  set :environment,       SCore.gem_environment
  set :sprockets,         Sinatra::Sprockets.environment

  configure do
    self.run_initializers
    use Rack::Session::Cookie,    secret: SCore::Config.settings.csrf.secret
    use Rack::Csrf,               raise: true
    use                           Rack::Flash
  end

  before do
    gon.csrf_token = Rack::Csrf.csrf_token(env)
  end

  load_and_persist_application # /etc/lib/app_loader
end