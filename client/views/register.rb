module DonnaClient
  module Views
    class Register < DonnaClient::Views::BaseView
      def take_control
        loop do
          puts render({})

          puts "Your name:"
          name = STDIN.gets

          puts "Your email:"
          email = STDIN.gets

          puts "Your password:"
          password = STDIN.gets

          name, email, password = [name, email, password].map(&:strip)
          puts "Registering new user #{name}, #{email}"

          DonnaClient::Controllers::User.register name, email, password
          return :home
        end
      end
    end
  end
end

DonnaClient::Views.register_view :register, DonnaClient::Views::Register
