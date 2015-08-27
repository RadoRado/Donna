module DonnaClient
  module Views
    class << self
      def views
        @views ||= {}
      end

      def register_view(view_name, view_class)
        views[view_name] = view_class
      end
    end
  end
end

module DonnaClient
  class ViewDispatcher
    attr_reader :current_view
    attr_accessor :configuration

    def initialize(start_view, configuration)
      @current_view = start_view
      @configuration = configuration
      @views = DonnaClient::Views.views

      load_views
    end

    def load_views
      Dir['views/*.rb'].each do |view_file|
        view_name = File.basename(view_file, '.rb')

        require_relative "views/#{view_name}"
      end
    end

    def dispatch
      loop do
        next_view = @views[@current_view].new.take_control

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
