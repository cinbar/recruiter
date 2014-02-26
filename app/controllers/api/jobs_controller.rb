class Api::JobsController < ApplicationController
  include ActiveSupport::NumberHelper  
  
  skip_before_filter :authenticate_user!, only: [:create]
  
  respond_to :json
  
  def create
    job = JSON.parse(params[:job])
    # There is a nested json file within the job param... or at least there should be
    job_data = JSON.parse(job["json"])
    startup_data = JSON.parse(job["startup_json"])
    Rails.logger.debug(startup_data)
    job_tags = job_data["tags"]
    market_tags = startup_data["markets"]
    
    skill_tags   = job_tags.reject{|tag| tag["tag_type"] != "SkillTag"}.collect{|tag| tag["display_name"] if tag["display_name"].present?}
    market_tags  = market_tags.collect{|tag| tag["display_name"] if tag["display_name"].present?} if market_tags.present?
    role         = job_tags.reject{|tag| tag["tag_type"] != "RoleTag"}
    location     = job_tags.reject{|tag| tag["tag_type"] != "LocationTag"}

    @existing_job = Job.find_by_source_id_and_source_job_id_and_source_company_id(job["source_id"], job["source_job_id"], job["source_company_id"])
    if @existing_job
      Rails.logger.debug("Duplicate job detected, skipping")
      head :duplicate and return
    else
      @job = Job.new
      # meta data 
      @job.source_url        = job["source_url"]
      @job.source_id         = job["source_id"]
      @job.source_company_id = job["source_company_id"]
      @job.source_job_id     = job["source_job_id"]
    
      @job.json          = job["json"]
    
      @job.title         = job_data["title"]
      @job.position      = role.first.fetch("display_name", {}) if role && role.any?
      @job.company       = startup_data["name"].capitalize if startup_data["name"].present?
      @job.salary_min    = job_data["salary_min"]
      @job.salary_max    = job_data["salary_max"]
      @job.equity_min    = job_data["equity_min"]
      @job.equity_max    = job_data["equity_max"]
      # kind of unneccesary given the above, but whatever:
      @job.salary        = "#{number_to_delimited(job_data["salary_min"], :delimiter => ',')} - #{number_to_delimited(job_data["salary_max"], :delimiter => ',')} : #{job_data["equity_min"]}%-#{job_data["equity_max"]}%"
      @job.location      = location.first.fetch("display_name", {}) if location && location.any?
      @job.description   = "#{job_data["description"] || startup_data["product_desc"]}"
      @job.company_rank  = startup_data["quality"]
      @job.company_url   = startup_data["company_url"]
      @job.hero_img      = job["hero_img"]
      @job.logo_img      = startup_data["thumb_url"]
      @job.tags          = market_tags.join(", ") if market_tags 
      @job.skills        = skill_tags.join(", ") if skill_tags
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
end