module DonnaClient
  module Views
    class Sync < DonnaClient::Views::BaseView

      def take_control
        user = DonnaClient::State.user
        url = DonnaClient::Controllers::Sync.get_google_sync_url user.id
        puts render({ url: url })
        loop do
          command = STDIN.gets
          return :profile if command.strip == 'ready'
        end
      end
    end
  end
end

DonnaClient::Views.register_view(:sync, DonnaClient::Views::Sync)
