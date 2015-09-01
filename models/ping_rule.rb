# rubocop:disable Style/Documentation

require 'time'

class PingRule < ActiveRecord::Base
  has_many :pings, dependent: :destroy
  belongs_to :contact
  belongs_to :user

  def get_pings_for_user_between(begin_of_week, end_of_week)
    rules = user.ping_rules
    pings_density = [0, 0, 0, 0, 0, 0, 0]

    rules.each do |rule|
      rule.pings.each do |ping|
        if ping.target_week >= begin_of_week || \
          ping.target_week + 6 <= end_of_week

          index_of_day = ping.target_day.to_date.cwday - 1
          pings_density[index_of_day] += 1
        end
      end
    end

    pings_density
  end

  def suggest_day_from_schedule
    created_at_date = created_at.to_date

    case schedule
    when 'soon'
      day = created_at_date +  7
    when 'later'
      day =  created_at_date + 2 * 7
    when 'far'
      day = created_at_date + 3 * 7
    end

    day
  end

  def suggest_target_day(target_week_start, target_week_end)
    density = get_pings_for_user_between(target_week_start,
                                         target_week_end)

    target_day = target_week_start + density.rindex(density.min)
    target_day
  end

  # Things that are not working:
  # 1. The logic from pings helper is not migrated - the state is not restored
  # 2. Consecutive months is not taken into acount at all
  def figure_out_pings
    day_in_future = suggest_day_from_schedule
    target_week_start, target_week_end = DateHelper.start_and_end_of_week day_in_future
    target_day = suggest_target_day(target_week_start,
                                    target_week_end)

    ping = Ping.create(target_day: target_day,
                       target_week: target_week_start,
                       ping_rule: self)
    ping.save
    ping
  end
end
