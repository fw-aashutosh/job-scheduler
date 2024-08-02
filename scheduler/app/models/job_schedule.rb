class JobSchedule < ApplicationRecord
  enum interval_type: { once: 'once', daily: 'daily', weekly: 'weekly', monthly: 'monthly' }

  belongs_to :job

  def next_execution_time
    return nil if end_time && Time.current > end_time
    
    time_parts = time_of_day.split(":")
    schedule_hour = time_parts[0]
    schedule_minute = time_parts[1]

    next_time = start_time.change(hour: schedule_hour, min: schedule_minute, sec: 0)
    case interval_type
    when 'once'
      next_time = start_time
    when 'daily'
      next_time = start_time + (24 * 60 * 60)
    when 'weekly'
      next_time = find_next_weekday(next_time, interval_value)
    when 'monthly'
      next_time = find_next_month_date(next_time, interval_value)
    end
  end

  private
    def find_next_weekday(current_time, weekday)
      target_weekday = (weekday % 7) 
      target_weekday = (target_weekday == 0 ? 6 : target_weekday - 1) # Convert to 0-6 (0 = Sunday)
  
      #wday takes 0 = sunday
      current_weekday = current_time.wday
      days_until_next = (target_weekday - current_weekday + 7) % 7
      days_until_next = days_until_next == 0 ? 7 : days_until_next 
      
      current_time + days_until_next.days
    end

    def find_next_month_date(current_time, day_of_month)
      next_time = current_time
      # Check if day_of_month is valid for the current month
      if day_of_month > 0
        next_time = next_time.change(day: day_of_month)
        
        if next_time < current_time
          next_time = (next_time >> 1).change(day: day_of_month)
        end
      end
    end
end
