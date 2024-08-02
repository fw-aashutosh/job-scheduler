require 'sidekiq-scheduler'

class SchedulerWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  # def markTaskAsProcessing(task_execution_id):
  #   task_execution = TaskExecution.find(id)
  #   task_execution.update(status: 'started')
  # end
  
  
  # def doTasks
  #   print "####################### - Executing Task - #######################"
  #   ExecutionWorker.perform_async()
  #   print "####################### - Finished Task - #######################"
  # end

  def fetchScheduledTasks
    task_executions = TaskExecution.scheduled_tasks
    print "############# - Scheduled Task Fetched - ############# \n"
    return task_executions
  end

  def createRecurringTask(task_execution)
    if task_execution.job.is_recurring
      recurring_task_start_time = task_execution.job.get_next_execution_time
      new_task_execution = TaskExecution.create(job_id:t ask_execution.job.id,start_time: recurring_task_start_time, status: 'scheduled')
      new_task_execution.save
    # new_task_execution = TaskExecution.create(start_time: 1.minute.from_now, status: 'scheduled')
    # new_task_execution.save
    print "############# - Recurring Task Created - #############\n"
  end

  def executeTask(task_execution)
    ExecutionWorker.perform_async(task_execution)
  end


  def perform
    # Your background job logic here
    print "############# - Running Scheduler Worker on time  #{Time.now} #############  \n"

    task_executions = self.fetchScheduledTasks
    task_executions.each do |task_execution|
      self.executeTask(task_execution.id)
      self.createRecurringTask(task_execution)
    end
  
  end

end