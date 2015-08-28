module DonnaClient
  module Controllers
    module Sync
      extend self

      def get_google_sync_url
        r = HTTP.get(DonnaClient::State['api_url'] + '/sync/google')
        body = JSON.parse(r.body.to_s)
        body['url']
      end
    end
  end
end
