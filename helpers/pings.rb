require 'time'

module Sinatra
  module PingHelper
    def get_start_and_of_week(day)
      monday = day - (day.wday - 1) % 7
      sunday = monday + 6

      return [monday, sunday]
    end

    def get_pings_for_user_between(ping_rule, begin_of_week, end_of_week)
      rules = ping_rule.user.ping_rules
      pings_density = [0, 0, 0, 0, 0, 0, 0]

      rules.each do |rule|
        rule.pings.each do |ping|
          if ping.target_week >= begin_of_week || ping.target_week + 6 <= end_of_week
            index_of_day = ping.target_day.to_date.cwday - 1

            pings_density[index_of_day] += 1
          end
        end
      end

      pings_density
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
      density = get_pings_for_user_between ping_rule, target_week_start, target_week_end

      p density
      p density.rindex(density.min)

      target_day = target_week_start + density.rindex(density.min)

      ping = Ping.create(target_day: target_day, target_week: target_week_start, ping_rule: ping_rule)
      ping.save
      ping
    end
  end
end
