class CreateTaskExecutions < ActiveRecord::Migration[7.1]
  def change
    create_table :task_executions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.datetime :last_updated_time

      t.timestamps
    end
  end
end
