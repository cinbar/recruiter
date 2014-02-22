class JobsController < ApplicationController
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new
    @job.title         = params[:job][:title]
    @job.source_url    = params[:job][:source_url]
    @job.source_id     = params[:job][:source_id]
    @job.source_domain = params[:job][:source_domain]
    @job.json          = params[:job][:json]
    begin
      @job.save
      head :created
    rescue Exception => e
      Rails.logger.error("Failed to create job. #{e.message}")
      head :bad_request
    end
  end
end