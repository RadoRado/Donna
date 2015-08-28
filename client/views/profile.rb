module DonnaClient
  module Views
    class Profile

      def take_control
        loop do
          user = DonnaClient::State.user

          puts user.id
          puts user.name
          puts user.email

          puts render
          command = STDIN.gets
        end
      end

      def render
      end
    end
  end
end

DonnaClient::Views.register_view(:profile, DonnaClient::Views::Profile)
