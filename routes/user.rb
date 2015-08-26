require 'json'
require 'bcrypt'

class Donna < Sinatra::Base

  before '/user/*' do
    content_type 'application/json'

    next unless request.post?

    @request_data = JSON.parse(request.body.read.to_s)
  end

  post '/user/register' do
    unless ["name", "email", "password"].all? { |key| @request_data.key? key }
      halt 400, { "message" => "Missing fields" }.to_json
    end

    if User.find_by email: @request_data["email"]
      halt 422, { "message" => "User already exists" }.to_json
    end

    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(@request_data["password"], password_salt)

    user = User.create(email: @request_data["email"], name: @request_data["name"],
                       password: password_hash, password_salt: password_salt)
    user.save

    { "message" =>  "User registered" }.to_json
  end

  post '/user/login' do
    unless ["email", "password"].all? { |key| @request_data.key? key }
      halt 400, {"message" => "Missing fields" }.to_json
    end

    user = User.find_by email: @request_data["email"]

    unless user
      halt 404, {"message" => "User not found"}.to_json
    end

    unless user.password == BCrypt::Engine.hash_secret(@request_data["password"], user.password_salt)
      halt 403, {"message" => "Wrong username/password"}.to_json
    end
  end

  get '/user/list' do
    User.all.select(:id, :name, :email).to_json
  end
end
