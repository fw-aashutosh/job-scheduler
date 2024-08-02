class JobController < ApplicationController
  def index
  end

  def create
    # @job = Job.new(name: "Sample Job 1", description: "Sample Description 1")
    # @job.save
  
    # interval_type = 'weekly'
    # interval_value = 0
    # time_string = "08:00:00"
    # time_format = "%H:%M:%S"
    # @time_obj = Time.strptime(time_string, time_format).change(year: Time.now.year, month: Time.now.month, day: Time.now.day)

    # @job_schedule = JobSchedule.new(
    #   start_time: Time.now,
    #   end_time: nil,
    #   interval_type: interval_type,
    #   interval_value: interval_value,
    #   time_of_day: @time_obj,
    #   job: @job,
    # )

    # daily
    @job = Job.new(name: "Sample Job 2", description: "Sample Description 2")
    @job.save
  
    interval_type = 'daily'
    interval_value = 0
    time_string = "08:00:00"

    @job_schedule = JobSchedule.new(
      start_time: Time.now,
      end_time: nil,
      interval_type: interval_type,
      interval_value: interval_value,
      time_of_day: time_string,
      job: @job,
    )
    @job_schedule.save

    next_execution_time = @job_schedule.next_execution_time
    @task_execution = TaskExecution.new(
      job_id: @job.id, start_time: next_execution_time, end_time: nil, status: 'scheduled'
    )
    @task_execution.save



end
