class Report < ApplicationRecord

	@reports = Hash.new 

	def self.add_hours_tracked(hours_tracker)
		# Check if the record for that employee for that period exists
		# Key is [employee_id-payperiod(yyyy-mm-dd)]
		key = create_key(hours_tracker)
		amount = calculate_amount(hours_tracker)
		if (@reports.has_key?(key))
			#update
			@reports[key] = @reports[key] + amount
		else
			#add record for that employee for that pay period
			@reports[key] = amount
		end
	end

	def self.generate_report
		return @reports
	end

	private

	def self.create_key(hours_tracker)
		# Based on hours_tracker.work_data, the pay period is determined
		work_date = hours_tracker.work_date
		start_pay_date = Date.new(work_date.year, work_date.month, 1)
		end_pay_date = Date.new(work_date.year, work_date.month, 15)
		if work_date.mday > 15
			start_pay_date = Date.new(work_date.year, work_date.month, 15)
			end_pay_date = work_date.end_of_month
		end
		key = "#{hours_tracker.employee_id}:#{start_pay_date.strftime} - #{end_pay_date.strftime}"
	end

	def self.calculate_amount(hours_tracker)
		#job group A is paid $20/hr, and job group B is paid $30/hr
		rate_per_hours = 0
		if hours_tracker.job_group == 'A'
			rate_per_hours = 20
		elsif hours_tracker.job_group == 'B'
			rate_per_hours = 30
		end
		amount = hours_tracker.hours_worked * rate_per_hours
	end
end
