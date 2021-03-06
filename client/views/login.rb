module DonnaClient
  module Views
    class Login < DonnaClient::Views::BaseView
      def take_control
        loop do
          puts render({})

          puts "Your email:"
          email = STDIN.gets

          puts "Your password:"
          password = STDIN.gets

          email, password = [email, password].map(&:strip)

          if DonnaClient::Controllers::User.login email, password
            sleep 2
            return :profile
          end

          puts "Wrong username/password! Try again"
        end
      end
    end
  end
end

DonnaClient::Views.register_view :login, DonnaClient::Views::Login
