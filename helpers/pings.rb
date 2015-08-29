require 'time'

module Sinatra
  module PingHelper
    def get_start_and_of_week(day)
      monday = day - (day.wday - 1) % 7
      sunday = monday + 6

      return [monday, sunday]
    end

    def figure_out_pings_for(ping_rule)
      created_at = ping_rule.created_at.to_date
      today_in_future = Date.today

      case ping_rule.schedule
      when 'soon'
        today_in_future = created_at + 7
      when 'later'
        today_in_future = created_at + 2 * 7
      when 'far'
        today_in_future = created_at + 3 * 7
      end

      target_week_start, target_week_end = get_start_and_of_week today_in_future

      p today_in_future
      p target_week_start
      p target_week_end
    end
  end
end
