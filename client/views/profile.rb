require 'time'

module DonnaClient
  module Views
    class Profile < DonnaClient::Views::BaseView

      def take_control
        loop do
          user = DonnaClient::State.user

          puts render({ name: user.name, today: Time.now.strftime("%d/%m/%Y %H:%M") })
          command = STDIN.gets

          return :sync if command.strip == "sync"
        end
      end
    end
  end
end

DonnaClient::Views.register_view(:profile, DonnaClient::Views::Profile)
