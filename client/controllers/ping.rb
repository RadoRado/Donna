# rubocop:disable Style/Documentation

module DonnaClient
  module Controllers
    module Ping
      extend self

      def make_a_ping(ping_payload)
        r = HTTP.post(DonnaClient::State['api_url'] + '/ping/create', :json => ping_payload)

        return nil unless r.status == 200

        JSON.parse(r.body.to_s)['ping']
      end
    end
  end
end
