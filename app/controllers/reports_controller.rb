class ReportsController < ApplicationController

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  def new
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    reports = Hash.new 
    hours_trackers = HoursTracker.where(report_id: params[:report_id]) 
    HoursTracker.where(report_id: params[:report_id]).find_each do |hours_tracker|
      Report.add_hours_tracked(hours_tracker)
    end
    @reports = Report.generate_report
  end

  def createReport

  end

end
