class Api::JobsController < ApplicationController
  include ActiveSupport::NumberHelper  
  
  skip_before_filter :authenticate_user!, only: [:create]
  
  respond_to :json
  
  def create
    job = JSON.parse(params[:job])
    # There is a nested json file within the job param... or at least there should be
    job_data = JSON.parse(job["json"]) if job["json"]
    startup_data = job_data["startup"] if job
    
    all_tags = job_data["tags"]
    skill_tags = all_tags.collect{|tag| tag["display_name"] if tag["tag_type"] == "SkillTag" && tag["display_name"]}
    location   = all_tags.collect{|tag| tag["tag_type"] == "LocationTag" && tag["name"]}.first
    
    @existing_job = Job.find_by_source_id_and_source_job_id_and_source_company_id(job["source_id"], job["source_job_id"], job["source_company_id"])
    if @existing_job.present?
      respond_to do |format|
        format.json { head :bad_request, error: "Job already exists."}
      end
    end
    
    @job = Job.new
    # meta data 
    @job.source_url        = job["source_url"]
    @job.source_id         = job["source_id"]
    @job.source_company_id = job["source_company_id"]
    @job.source_job_id     = job["source_job_id"]
    
    @job.json          = job["json"]
    
    @job.title         = job_data["title"]
    @job.company       = startup_data["name"].capitalize if startup_data["name"].present?
    @job.salary_min    = job_data["salary_min"]
    @job.salary_max    = job_data["salary_max"]
    @job.equity_min    = job_data["equity_min"]
    @job.equity_max    = job_data["equity_max"]
    # kind of unneccesary given the above, but whatever:
    @job.salary        = "#{number_to_delimited(job_data["salary_min"], :delimiter => ',')} - #{number_to_delimited(job_data["salary_max"], :delimiter => ',')} : #{job_data["equity_min"]}%-#{job_data["equity_max"]}%"
    @job.location      = location
    @job.description   = job_data["description"] || startup_data["description"]
    @job.hero_img      = job["hero_img"]
    @job.logo_img      = startup_data["thumb_url"]
    @job.tags          = skill_tags if skill_tags.any?
    @job.source_created_at = job_data["created_at"]
    @job.source_updated_at = job_data["updated_at"]

    begin
      @job.save!
      flash[:info] = "Job created."
    rescue Exception => e
      Rails.logger.error("Failed to create job. #{e.message}")
      flash[:error] = "Failed to create job."
      respond_to do |format|
        format.json { head :bad_request, error: flash[:info]}
      end
    end
    
    respond_to do |format|
      format.json { head :created}
    end
  end
end