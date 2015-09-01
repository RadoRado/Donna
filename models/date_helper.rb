module DateHelper
  module_function

  def start_and_end_of_week(day)
    monday = day - (day.wday - 1) % 7
    sunday = monday + 6

    [monday, sunday]
  end
end
