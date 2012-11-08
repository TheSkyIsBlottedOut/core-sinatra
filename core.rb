require 'rubygems'
require 'bundler'
require 'hashie'
require 'sass'
require 'compass'

begin
  current_directory = File.dirname(__FILE__)
  require File.join(current_directory, 'etc/score.rb')
  SCore.start(
    root_path:    current_directory,
    environment:  ENV['SCORE_ENV'] || 'development'
  )
  Bundler.require(:default, SCore.gem_environment)
  SCore.load_framework
  require File.join(SCore.root, '/application.rb')
end