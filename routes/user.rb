class Donna < Sinatra::Base
  before '/user/*' do
    content_type 'application/json'
  end

  get '/user/list' do
    User.all.to_json
  end
end
