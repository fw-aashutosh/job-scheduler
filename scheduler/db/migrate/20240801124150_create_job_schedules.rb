class CreateJobSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :job_schedules, id: :primary_key do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :interval_type
      t.integer :interval_value
      t.time :time_of_day
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
