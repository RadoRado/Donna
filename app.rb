require 'sinatra/base'
require "sinatra/activerecord"

require_relative 'models/init'
require_relative 'routes/init'

class Donna < Sinatra::Base
  set :app_file, __FILE__

  register Sinatra::ActiveRecordExtension
end
