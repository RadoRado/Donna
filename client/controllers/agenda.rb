module DonnaClient
  module Controllers
    module Agenda
      extend self

      def get_agenda_for(user, weeks)
        r = HTTP.get(DonnaClient::State['api_url'] + '/ping/' + user.id.to_s + '/' + weeks.to_s)

        return nil unless r.status == 200

        JSON.parse(r.body.to_s)
      end
    end
  end
end
