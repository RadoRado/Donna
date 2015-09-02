require_relative '../test_helper'
require_relative '../../app'
require 'minitest/autorun'
require 'rack/test'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

class UserRoutesTest < Minitest::Test
  include Rack::Test::Methods

  def setup
    DatabaseCleaner.start
    user = User.create(email: 'always@registered.com',
                       name: 'Rado the Registered',
                       password: '123')
    user.save

    @always_registered = user
  end

  def teardown
    DatabaseCleaner.clean
  end

  def app
    Donna.new
  end

  def test_root
    get '/'
    assert last_response.ok?
  end

  def test_user_list
    get '/user/list'

    assert last_response.ok?
  end

  def test_register_with_missing_fields
    payload = { 'name' => 'Rado' }.to_json

    post '/user/register', payload
    body = JSON.parse(last_response.body)

    assert_equal 400, last_response.status
    assert body.key? 'message'
  end

  def test_register_successfully
    payload = { 'name' => 'Rado',
                'email' => 'radorado@hackbulgaria.com',
                'password' => 'mylittlesecret' }.to_json

    post '/user/register', payload
    body = JSON.parse(last_response.body)

    assert last_response.ok?
    assert body.key? 'message'
  end

  def test_register_existing_user
    payload = { 'name' => 'Rado',
                'email' => 'radorado@hackbulgaria.com',
                'password' => 'mylittlesecret' }.to_json

    post '/user/register', payload
    post '/user/register', payload
    body = JSON.parse(last_response.body)

    assert_equal 422, last_response.status
    assert body.key? 'message'
  end

  def test_login_with_missing_email
    payload = { 'password' => 'mylittlesecret' }.to_json
    post '/user/login', payload

    assert_equal 400, last_response.status
  end

  def test_login_with_missing_password
    payload = { 'email' => 'radorado@hackbulgaria.com' }.to_json
    post '/user/login', payload

    assert_equal 400, last_response.status
  end

  def test_user_login_successfuly
    payload = { 'email' => 'radorado@hackbulgaria.com',
                'name' => 'Rado',
                'password' => 'mylittlesecret' }.to_json

    post '/user/register', payload
    post '/user/login', payload

    assert last_response.ok?
  end

  def test_user_login_with_wrong_password
    payload = { 'name' => 'Rado',
                'email' => 'radorado@hackbulgaria.com',
                'password' => 'mylittlesecret' }.to_json

    post '/user/register', payload

    login_payload = {
      'email' => 'radorado@hackbulgaria.com',
      'password' => 'wrong'
    }.to_json

    post '/user/login', login_payload
    assert_equal 403, last_response.status
  end

  def test_login_with_unexisting_user
    login_payload = {
      'email' => 'vasko@hackbulgaria.com',
      'password' => 'wrong'
    }.to_json

    post '/user/login', login_payload
    assert_equal 404, last_response.status
  end

  def test_get_contact_for_existing_user
    get '/user/contact/' + @always_registered.id.to_s

    assert_equal 200, last_response.status
  end
end
