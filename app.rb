require 'sinatra/base'
require 'sinatra/config_file'
require 'sinatra/activerecord'

require_relative 'models/init'
require_relative 'routes/init'

class Donna < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  register Sinatra::ConfigFile

  config_file 'config/local_settings.yml'
  set :app_file, __FILE__
end
