# Core-Sinatra
Start with rackup -pPORT.

Sinatra + Mongoid + CoffeeScript + Sass + Gon + Sprockets.

## App-specific classes

*  SCore::Config     -> loads sitedata.yml configuration.
*  SCore::ApiKeys    -> loads apikeys.yml config for current run environment.
*  SCore::AppLoader  -> loads files and monitors mtimes (except assets/views, which are handled by sprockets/sinatra)

## About DB
Models are loaded in the DB:: namespace. This is entirely so that they can be removed from the DB:: namespace when the  file is modified, without accidentally removing a valuable constant. Yay for removing constants! :(


## Env triggers
*  SCORE_ENV         -> the application environment.


## Directory Structure
*  /assets           -> js, css, images
*  /application.rb   -> main application class
*  /config.ru        -> rackup file
*  /console          -> console shell script
*  /core.rb          -> common startup
*  /etc/score.rb     -> loads SCore class
*  /etc/config       -> YML files
*  /etc/extensions   -> core class extensions
*  /etc/init         -> app configuration initializers
*  /etc/lib          -> classes that autoload under ::SCore
*  /etc/middleware   -> environment-dependent initializers
*  /etc/sprockets.rb -> sprockets/asset pipeline (which requires an even different environment)
*  /etc/tasks        -> rake tasks
*  /helpers          -> helper functions
*  /models           -> models (loaded into DB::)
*  /public           -> public files
*  /routes           -> route blocks
*  /views            -> templates