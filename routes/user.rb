require 'json'
require 'bcrypt'

class Donna < Sinatra::Base


  before '/user/*' do
    content_type 'application/json'

    next unless request.post?

    @request_data = JSON.parse(request.body.read.to_s)
  end

  post '/user/register' do
    unless ['name', 'email', 'password'].all? { |key| @request_data.key? key }
      halt_with_message(400, 'Missing fields')
    end

    if User.find_by email: @request_data['email']
      halt_with_message(422, 'User already exists')
    end

    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(@request_data['password'], password_salt)

    user = User.create(email: @request_data['email'], name: @request_data['name'],
                       password: password_hash, password_salt: password_salt)
    user.save

    success_with_message('User registered')
  end

  post '/user/login' do
    unless ['email', 'password'].all? { |key| @request_data.key? key }
      halt_with_message(400, 'Missing fields')
    end

    user = User.find_by email: @request_data['email']

    unless user
      halt_with_message(404, 'User not found')
    end

    unless user.password == BCrypt::Engine.hash_secret(@request_data['password'], user.password_salt)
      halt_with_message(403, 'Wrong username/password')
    end

    user.public_user.to_json
  end

  get '/user/list' do
    User.all.select(:id, :name, :email).to_json
  end


  get '/user/contact/:user_id' do
    user = User.find_by(id: params['user_id'])
    halt_with_message(404, 'User not found') unless user

    user.contacts.to_json
  end

  get '/contact/:contact_id' do
    c = Contact.find_by(id: params['contact_id'])
    halt_with_message(404, 'Contact not found') unless c

    c.to_json
  end
end
