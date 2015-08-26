require_relative 'home'
require_relative 'register'

module DonnaClient
  class ViewDispatcher
    attr_reader :current_view
    attr_accessor :configuration

    def initialize(start_view, configuration)
      @current_view = start_view
      @configuration = configuration

      @views = { home: DonnaClient::Views::Home.new,
                 register: DonnaClient::Views::Register.new }
    end

    def dispatch
      loop do
        next_view = @views[@current_view].take_control

        return if next_view.nil?

        unless @views.key? next_view
          puts "Cannot find view for #{next_view}"
          puts "Quiting now."
          return
        end

        @current_view = next_view
      end
    end
  end
end
