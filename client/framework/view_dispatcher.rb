# rubocop:disable Style/Documentation

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

    def initialize(start_view)
      @current_view = start_view
      @views = DonnaClient::Views.views
    end

    def cant_find_view
      unless @views.key? next_view
        puts "Cannot find view for #{next_view}"
        puts 'Quiting now.'
        false
      end

      true
    end

    def dispatch
      loop do
        system 'clear'
        next_view = @views[@current_view].new.take_control

        return if next_view.nil?
        return if cant_find_view next_view
        @current_view = next_view
      end
    end
  end
end
