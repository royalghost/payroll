class AddReportIdToHoursTracker < ActiveRecord::Migration[5.1]
  def change
    add_column :hours_trackers, :report_id, :integer
  end
end
