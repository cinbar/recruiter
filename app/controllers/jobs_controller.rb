class JobsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create]
  respond_to :json
  
  def new
    @job = Job.new
  end
  def show 
    @job = Job.find(params[:id])
  end

  def edit 
    @job = Job.find(params[:id])
     respond_to do |format|
      format.html {
        render(layout: false) if request.xhr?
      }
    end
  end
  def update
    @job = Job.find(params[:id])
    respond_to do |format|
      if @job.update_attributes(params[:employee])
        format.html { redirect_to jobs_path, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end
  def create
    Rails.logger.debug("Received job")
    
    job = JSON.parse(params[:job])

    Rails.logger.debug("#{job}")
    @job = Job.new
    @job.title         = job["title"]
    @job.source_url    = job["source_url"]
    @job.source_id     = job["source_id"]
    @job.source_domain = job["source_domain"]
    @job.json          = job["json"]
    @job.company       = job["company"]
    @job.salary        = job["salary"]
    @job.location      = job["location"]
    @job.description   = job["description"]
    @job.hero_img      = job["hero_img"]
    @job.logo_img      = job["logo_img"]
    @job.tags          = job["tags"]
    @job.user_id = current_user.id if current_user
    begin
      @job.save!
      flash[:info] = "Job created."
    rescue Exception => e
      Rails.logger.error("Failed to create job. #{e.message}")
      flash[:error] = "Failed to create job."
      respond_to do |format|
        format.html { render :new }
        format.json { head :bad_request, error: flash[:info]}
      end
    end
    
    respond_to do |format|
      format.html {redirect_to jobs_path}
      format.json { head :created}
    end
  end
  
  def index
    @jobs = Job.paginate(:page => params[:page])
  end
end