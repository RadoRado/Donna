# rubocop:disable Style/Documentation

class Ping < ActiveRecord::Base
  belongs_to :ping_rule

  def between(start_date, end_date)
    test_date = target_day

    start_date, _ = DateHelper.start_and_end_of_week(start_date)
    _, end_date = DateHelper.start_and_end_of_week(end_date)

    start_date <= test_date && end_date >= test_date
  end
end
