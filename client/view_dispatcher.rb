module DonnaClient
  module Views
    class << self
      def views
        @views ||= {}
      end

      def register_view(view_name, view_class)
        views[view_name] = view_class
      end

      def trim_lines(content)
        content.split("\n").map(&:strip).join("\n")
      end
    end
  end
end

module DonnaClient
  class ViewDispatcher
    attr_reader :current_view

    def initialize(start_view)
      @current_view = start_view
      @views = DonnaClient::Views.views

      load(:models)
      load(:controllers)
      load(:views)
    end

    def load(what)
      Dir["#{what}/*.rb"].each do |file|
        without_extension = File.basename(file, '.rb')

        require_relative "#{what}/#{without_extension}"
      end
    end

    def dispatch
      loop do
        system 'clear'
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
