module DonnaClient
  module Controllers
    module Ping
      extend self

      def make_a_ping(contact_id, times_a_month, consecutive_months, schedule)
        payload = {
          'contact_id' => contact_id,
          'times_a_month' => times_a_month,
          'consecutive_months' => consecutive_months,
          'schedule' => schedule
        }
        r = HTTP.post(DonnaClient::State['api_url'] + '/ping/create', :json => payload)
        p r.status
        p r.body.to_s
        sleep 10
      end
    end
  end
end
