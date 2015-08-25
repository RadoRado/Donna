require 'json'

class Donna < Sinatra::Base
  before '/user/*' do
    content_type 'application/json'
    @request_data = JSON.parse(request.body.read.to_s)
  end

  post '/user/register' do
    unless ["name", "email", "password"].all? { |key| @request_data.key? key }
      halt 400, { "message" => "Missing fields" }.to_json
    end

    { "message" =>  "User registered" }.to_json
  end

  get '/user/list' do
    User.all.to_json
  end
end
