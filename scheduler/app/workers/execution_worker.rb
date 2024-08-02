class ExecutionWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  def markTaskAsProcessing(task_execution_id)
    task_execution = TaskExecution.find_by(id: task_execution_id)
    print "\nTask Processung start\n", task_execution
    task_execution.update(status: 'started')
  end

  def markTaskAsFailed(task_execution_id)
    task_execution = TaskExecution.find_by(id: task_execution_id)
    print "\nTask Processing failed\n", task_execution
    task_execution.update(status: 'failed')
  end

  def markTaskAsCompleted(task_execution_id)
    task_execution = TaskExecution.find_by(id: task_execution_id)
    task_execution.update(status: 'completed')
  end

  def execute
    print "############# - Task Execution Started - ############# \n"
    sleep(30)
    print "############# - Task Executed Successfully - ############# \n"
  end

  def perform(task_execution_id)
    print " ###### - task_execution - task_execution ---- ", task_execution_id
    begin
      self.markTaskAsProcessing(task_execution_id)
      self.execute
      self.markTaskAsCompleted(task_execution_id)
    rescue => e
      print "############# - Execution Failed - ######## #{e.message}"
      self.markTaskAsFailed(task_execution_id)
    end
  end

end