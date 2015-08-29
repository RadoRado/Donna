module Sinatra
  module HaltHelper
    def success_with_message(message)
      { "message" => message }.to_json
    end

    def success_with_object(object)
      return object.to_json
    end

    def halt_with_message(status, message)
      halt status, {"message" => message}.to_json
    end
  end
end
