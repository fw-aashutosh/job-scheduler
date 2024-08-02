class AddJobReferenceToTaskExecution < ActiveRecord::Migration[7.1]
  def change
    add_reference :task_executions, :job, null: true, foreign_key: true
  end
end
