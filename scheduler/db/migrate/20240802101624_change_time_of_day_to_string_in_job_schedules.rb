class ChangeTimeOfDayToStringInJobSchedules < ActiveRecord::Migration[7.1]
  def change
    change_column :job_schedules, :time_of_day, :string
  end
end
