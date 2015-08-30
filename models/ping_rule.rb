# rubocop:disable Style/Documentation

require 'time'

class PingRule < ActiveRecord::Base
  has_many :pings, dependent: :destroy
  belongs_to :contact
  belongs_to :user

  def suggles_day_from_schedule
    created_at = create_at.to_date

    case schedule
    when 'soon'
      day = created_at + 7
    when 'later'
      day = created_at + 2 * 7
    when 'far'
      day = created_at + 3 * 7
    end

    day
  end

  def suggest_target_day(day_in_future)
    target_week_start, target_week_end = start_and_end_of_week day_in_future
    density = get_pings_for_user_between(ping_rule,
                                         target_week_start,
                                         target_week_end)
    target_day = target_week_start + density.rindex(density.min)

    target_day
  end

  # Things that are not working:
  # 1. The logic from pings helper is not migrated - the state is not restored
  # 2. Consecutive months is not taken into acount at all
  def figure_out_pings
    day_in_future = suggest_day_from_schedule
    target_day = suggest_target_day day_in_future

    ping = Ping.create(target_day: target_day,
                       target_week: target_week_start,
                       ping_rule: ping_rule)
    ping.save
  end
end
