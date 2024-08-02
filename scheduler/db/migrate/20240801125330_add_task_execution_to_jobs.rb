class AddTaskExecutionToJobs < ActiveRecord::Migration[7.1]
  def change
    add_reference :jobs, :task_execution, null: true, foreign_key: true
  end
end
