require_relative '../../app'
require_relative '../test_helper'
require 'minitest/autorun'
require 'rack/test'

class UserRoutesTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Donna.new
  end

  def test_root
    get '/'
    assert last_response.ok?
  end

  def test_register_with_missing_fields
    payload = {"name" => "Rado" }.to_json

    post '/user/register', payload
    body = JSON.parse(last_response.body)

    assert_equal 400, last_response.status
    assert body.key? "message"
  end
end
