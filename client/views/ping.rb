require 'time'

module DonnaClient
  module Views
    class Ping < DonnaClient::Views::BaseView

      def take_control
        loop do
          user = DonnaClient::State.user
          contacts = DonnaClient::Controllers::User.get_contacts user

          puts render({})
          command = STDIN.gets
        end
      end
    end
  end
end

DonnaClient::Views.register_view(:ping, DonnaClient::Views::Ping)
