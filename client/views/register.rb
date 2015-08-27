module DonnaClient
  module Views
    class Register
      def take_control
        loop do
          puts render
          command = STDIN.gets
        end
      end

      def render
        content = <<-CONTENT
          This is the register view.
          It will require your name, email and password.
        CONTENT
      end
    end
  end
end

DonnaClient::Views.register_view(:register, DonnaClient::Views::Register)
