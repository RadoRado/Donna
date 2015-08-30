# rubocop:disable Style/Documentation
class Donna < Sinatra::Base
  get '/' do
    erb :index
  end
end
