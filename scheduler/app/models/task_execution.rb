class TaskExecution < ApplicationRecord
  enum status: { scheduled: 'scheduled', started: 'started', completed: 'completed', failed: 'failed' }

  belongs_to :job
  
  scope :scheduled_tasks, -> {
    where(status: 'scheduled').where('start_time < ?', Time.now)
  }


end
