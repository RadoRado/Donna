module DonnaClient
  module Views
    class Profile < DonnaClient::Views::BaseView

      def take_control
        loop do
          user = DonnaClient::State.user

          puts render({ name: user.name })
          command = STDIN.gets
        end
      end
    end
  end
end

DonnaClient::Views.register_view(:profile, DonnaClient::Views::Profile)
