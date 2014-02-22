class JobsController < ApplicationController
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new
    @job.title = params[:jobs][:title]
    @job.source_url = params[:jobs][:source_url]
    @job.source_id = params[:jobs][:source_id]
    @job.source_domain = params[:jobs][:source_domain]
    @job.json = params[:jobs][:json]
    @job.save!
  end
end