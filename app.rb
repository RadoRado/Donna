require 'sinatra/base'
require "sinatra/activerecord"

require_relative 'models/init'
require_relative 'routes/init'

class Donna < Sinatra::Base
  before do
    content_type :json
  end

  register Sinatra::ActiveRecordExtension
end
