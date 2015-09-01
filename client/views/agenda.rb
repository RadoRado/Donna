module DonnaClient
  module Views
    class Agenda < DonnaClient::Views::BaseView

      def take_control
        user = DonnaClient::State.user
        weeks = 1
        weekly_agenda = DonnaClient::Controllers::Agenda.get_agenda_for(user, weeks)

        agenda = weekly_agenda.map do |ping|
          "Ping #{ping['contact_name']} at #{ping['target_day']}. Email: #{ping['contact_email']}"
        end
        .join("\n")

        puts render agenda: agenda, weeks: weeks

        STDIN.gets
        :profile
      end
    end
  end
end

DonnaClient::Views.register_view(:agenda, DonnaClient::Views::Agenda)
