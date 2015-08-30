# rubocop:disable Style/Documentation

require 'uri'

module DonnaClient
  module Controllers
    module Sync
      extend self

      def get_google_sync_url(user_id)
        r = HTTP.get(DonnaClient::State['api_url'] + '/sync/google', params: { userId: user_id })
        body = JSON.parse(r.body.to_s)
        URI.decode body['url']
      end
    end
  end
end
