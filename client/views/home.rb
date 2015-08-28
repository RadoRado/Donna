module DonnaClient
  module Views
    class Home

      def take_control
        loop do
          puts render
          command = STDIN.gets
          command = command.strip

          return :login if command == "login"
          return :register if command == "register"
        end
      end

      def render
        content = <<-CONTENT
          Hello, I am Donna. How can I help you?
          Enter the following commands, case insensitive, to proceed:
          1) Register
          2) Login
        CONTENT

        DonnaClient::Views.trim_lines content
      end
    end
  end
end

DonnaClient::Views.register_view(:home, DonnaClient::Views::Home)
