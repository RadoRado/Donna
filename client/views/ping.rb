require 'time'

module DonnaClient
  module Views
    class Ping < DonnaClient::Views::BaseView

      def autocomplete_contact
        loop do
          searched_contact = STDIN.gets
          searched_contact = searched_contact.strip.downcase

          return searched_contact.chomp(';').to_i if searched_contact.end_with? ';'

          suggestions = @contacts.select do |c|
            c["name"].downcase.include?(searched_contact) || c["email"].downcase.include?(searched_contact)
          end
          .map do |contact|
            "#{contact["id"]}: #{contact["name"]} - #{contact["email"]}"
          end

          puts "No suggesstions found" unless suggestions.length > 0
          puts suggestions.join("\n") if suggestions.length > 0
        end
      end

      def take_control
        @user = DonnaClient::State.user
        @contacts = DonnaClient::Controllers::User.get_contacts @user

        puts render({contacts_count: @contacts.length})

        contact_id = autocomplete_contact
        puts contact_id

        puts "How many times a month?"
        times_a_month = STDIN.gets.strip.to_i

        puts "How many consecutive months?"
        consecutive_months = STDIN.gets.strip.to_i

        puts "When to schedule the ping? (soon|later|far)"
        when_to_schedule = STDIN.gets.strip

        DonnaClient::Controllers::Ping.make_a_ping(contact_id, times_a_month, consecutive_months, when_to_schedule)
        puts "Ping created. Rest assured that you will be reminded"

        :profile
      end
    end
  end
end

DonnaClient::Views.register_view(:ping, DonnaClient::Views::Ping)
