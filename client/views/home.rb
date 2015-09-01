module DonnaClient
  module Views
    class Home < DonnaClient::Views::BaseView
      def take_control
        loop do
          puts render({})
          command = STDIN.gets.strip

          return :login if command == 'login'
          return :register if command == 'register'
        end
      end
    end
  end
end

DonnaClient::Views.register_view(:home, DonnaClient::Views::Home)
