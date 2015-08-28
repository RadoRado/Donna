module DonnaClient
  module Controllers
    module User
      extend self

      def register(name, email, password)
        payload = {
          "name" => name,
          "email" => email,
          "password" => password
        }

        r = HTTP.post(DonnaClient::State["api_url"] + '/user/register', :json => payload)
        p r.status
        p JSON.parse(r.body.to_s)
      end

      def login(email, password)
        payload = {
          "email" => email,
          "password" => password
        }

        r = HTTP.post(DonnaClient::State["api_url"] + '/user/login', :json => payload)
        body = JSON.parse(r.body.to_s)
        p body
        return r.status == 200
      end
    end
  end
end
