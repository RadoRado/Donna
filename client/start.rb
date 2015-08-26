require 'json'
require 'http'
require 'yaml'

require_relative 'views/view_dispatcher'

module DonnaClient
  class << self
    def start
      configuration = YAML::load_file(File.join(__dir__, 'config.yml'))
      vd = ViewDispatcher.new :home, configuration
      vd.dispatch
      # payload = {
      #   "email" => "radorado@hackbulgaria.com",
      #   "name" => "RadoRado",
      #   "password" => "123ruby"
      # }

      # r = HTTP.post(configuration["api_url"] + '/user/register', :json => payload)
      # p r.status
      # p JSON.parse(r.body.to_s)
    end
  end
end

DonnaClient::start
