class Job < ApplicationRecord

  has_one :job_schedule
  has_many :task_executions

  def is_recurring
    return false unless job_schedule

    if job_schedule.interval_type == 'once'
      return false
    end
    return true
  end

  def get_next_execution_time
    return job_schedule.next_execution_time
  end
end
