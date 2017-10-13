## Prabin Paudel (paudelp@gmail.com)
require 'csv'  

class WelcomeController < ApplicationController
  def index
  end

	def upload
		#Read CSV file
	  	uploaded_io = params[:hours_worked]
	  	if (uploaded_io == nil)
	  		flash[:notice] = "You need to first select a valid CSV file."
	  		redirect_to root_url
	  	else
	  		process_upload(uploaded_io.path)
	  	end
	end

	def process_upload(filename)
		csv_text = File.read(filename)
		csv_size = File.readlines(filename).size - 1 #returns including header
		#puts "CSV Size #{csv_size}" 
		count = 1
		csv = CSV.parse(csv_text, :headers => true)
		hours_tracker_map = Hash.new
		report_id_new = 0
		csv.each do |row|
			if count != csv_size
				hours_tracker_map[count] = row.to_hash
			else 
				#puts "line count is #{count}"
				report_id_new = row.to_hash["hours_worked"]
			end
			count  += 1
		end

		if (same_csv_uploaded(report_id_new))
	  		flash[:notice] = "The report with the same id is already uploaded."
	  		redirect_to root_url
		else
			save_csv(hours_tracker_map, report_id_new)
		end

	end

	def same_csv_uploaded(report_id_new)
		Report.find_by(report_id: report_id_new) != nil ? true : false
	end

	def save_csv(hours_tracker_map, report_id_new)
		#Save each hours to the database along with the report id
		hours_tracker_map.each  do |key, value|
			HoursTracker.create!( value.to_hash.merge!("report_id" => report_id_new) )
		end
		generate_report(report_id_new)
	end

	def generate_report(report_id_new)
		@report = Report.create!(report_id:report_id_new)
		redirect_to controller: "reports", action: "show", report_id: report_id_new
	end

end
