module Sinatra
  module RouteHelper
    def has_params(keys, params)
      keys.all? { |key| params.key? key }
    end
  end
end
