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

      load(:framework)
      load(:helpers)
      load(:models)
      load(:controllers)
      load(:views)

      vd = ViewDispatcher.new :home
      vd.dispatch
    end

    def load(what)
      Dir["#{what}/*.rb"].each do |file|
        without_extension = File.basename(file, '.rb')

        require_relative "#{what}/#{without_extension}"
      end
    end
  end
end

DonnaClient::start
