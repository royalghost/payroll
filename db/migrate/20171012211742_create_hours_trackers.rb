class CreateHoursTrackers < ActiveRecord::Migration[5.1]
  def change
    create_table :hours_trackers do |t|
      t.date :work_date
      t.float :hours_worked
      t.integer :employee_id
      t.string :job_group

      t.timestamps
    end
  end
end
