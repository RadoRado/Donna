require 'uri'
require 'json'
require 'oauth2'
require 'google_contacts_api'

class Donna < Sinatra::Base

  before '/sync/*' do
    CLIENT_ID = settings.GOOGLE_CLIENT_ID
    CLIENT_SECRET = settings.GOOGLE_CLIENT_SECRET
    REDIRECT_URI = 'http://localhost:9393/sync/google/success'

    client = OAuth2::Client.new(CLIENT_ID, CLIENT_SECRET,
           site: 'https://accounts.google.com',
           token_url: '/o/oauth2/token',
           authorize_url: '/o/oauth2/auth')
    url = client.auth_code.authorize_url(scope: "https://www.google.com/m8/feeds",
           redirect_uri: REDIRECT_URI)

    @client = client
    @url = url
  end

  get '/sync/google/success' do
    token = @client.auth_code.get_token(params["code"], :redirect_uri => REDIRECT_URI)
    google_contacts = GoogleContactsApi::User.new(token)

    user = User.find_by(id: params['state'])
    total_contacts = 0

    halt_with_message(404, "User not found") unless user

    non_empty_contacts = google_contacts.contacts.reject do |contact|
      contact.full_name.to_s.empty? || contact.primary_email.to_s.empty?
    end
    .map do |contact|
      total_contacts += 1
      user.contacts.build(name: contact.full_name, email: contact.primary_email)
    end

    user.save

    success_with_message("#{total_contacts} contacts imported")
  end

  get '/sync/google' do
    return halt_with_message(404, "userId is required") unless params.key? "userId"

    @url = @url + "&state=#{params['userId']}"

    content_type 'application/json'
    { url: URI.encode(@url) }.to_json
  end
end
