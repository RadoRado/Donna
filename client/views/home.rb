module DonnaClient
  module Views
    class Home

      def take_control
        loop do
          puts render
          command = STDIN.gets

          return :register if command.strip == "next"
        end
      end

      def render
        content = <<-CONTENT
          Hello, I am Donna. How can I help you?
          Enter the following commands, case insensitive, to proceed:
          1) Register
          2) Login
          For example, enter:
          login
        CONTENT

        content.split("\n").map(&:strip).join("\n")
      end
    end
  end
end

DonnaClient::Views.register_view(:home, DonnaClient::Views::Home)
