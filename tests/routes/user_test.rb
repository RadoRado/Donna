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
end
