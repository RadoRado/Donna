# rubocop:disable Style/Documentation
class Donna < Sinatra::Base
  before '/ping/*' do
    content_type 'application/json'

    next unless request.post?

    @request_data = JSON.parse(request.body.read.to_s)
  end

  get '/ping/:user_id/:n_weeks_from_now' do
    today = Date.today
    pings_until = today + params['n_weeks_from_now'].to_i * 7

    p today
    p pings_until

    result = []

    pings = Ping.all.order(:target_day).select do |ping|
      for_user = ping.ping_rule.user.id == params['user_id']
      for_user && ping_between(ping, today, pings_until)
    end

    pings.each do |ping|
      current = {}
      current[:ping_id] = ping.id
      current[:target_day] = ping.target_day
      current[:contact_name] = ping.ping_rule.contact.name

      current[:contact_email] = ping.ping_rule.contact.email

      result << current
    end

    result.to_json
  end

  # Should be done elswhere, not on HTTP call
  # But this will be fixed in the future
  post '/ping/create' do
    require_fields = %w(contact_id, times_a_month, consecutive_months, schedule)

    unless require_fields.all? { |key| @request_data.key? key }
      halt_with_message(400, 'Missing fields')
    end

    c = Contact.find_by(id: @request_data['contact_id'])
    halt_with_message(404, 'Contact not found') unless c

    pr = PingRule.create(
                       times_a_month: @request_data['times_a_month'],
                       consecutive_months: @request_data['consecutive_months'],
                       schedule: @request_data['schedule'],
                       contact: c,
                       user: c.user)
    pr.save
    pings = pr.figure_out_pings
    success_with_object(pings: pings)
  end
end
