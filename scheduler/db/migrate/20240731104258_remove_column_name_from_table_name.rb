class RemoveColumnNameFromTableName < ActiveRecord::Migration[7.1]
  def change
    remove_column :task_executions , :last_updated_time
  end
end
