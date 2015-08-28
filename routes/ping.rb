class Donna < Sinatra::Base

  before '/ping/*' do
    content_type 'application/json'

    next unless request.post?

    @request_data = JSON.parse(request.body.read.to_s)
  end

  post '/ping/create' do
    unless ["contact_id", "times_a_month", "how_many_months", "schedule"].all? { |key| @request_data.key? key }
      halt_with_message(400, "Missing fields")
    end
    # Should be done elswhere, not on HTTP call
    # But this will be fixed in the future
  end
end
