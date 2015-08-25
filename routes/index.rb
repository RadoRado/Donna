class Donna < Sinatra::Base
  get '/' do
    User.all.to_json
  end
end
