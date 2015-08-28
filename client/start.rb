require 'json'
require 'http'
require 'yaml'

require_relative 'state'
require_relative 'view_dispatcher'

module DonnaClient
  class << self
    def start
      configuration = YAML::load_file(File.join(__dir__, 'config.yml'))
      DonnaClient::State.conf = configuration

      vd = ViewDispatcher.new :home
      vd.dispatch
    end
  end
end

DonnaClient::start
