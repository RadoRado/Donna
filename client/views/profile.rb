require 'time'

module DonnaClient
  module Views
    class Profile < DonnaClient::Views::BaseView

      def take_control
        loop do
          user = DonnaClient::State.user

          puts render({ name: user.name, today: Time.now.strftime('%d/%m/%Y %H:%M') })
          command = STDIN.gets.strip

          return :sync if command== 'sync'
          return :ping if command== 'ping'
          return :agenda if command == 'agenda'
        end
      end
    end
  end
end

DonnaClient::Views.register_view(:profile, DonnaClient::Views::Profile)
