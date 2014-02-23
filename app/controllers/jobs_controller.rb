class JobsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create]
  respond_to :json
  
  def new
    @job = Job.new
  end
  
  def create
    @job = Job.new
    @job.title         = params[:job][:title]
    @job.company       = params[:job][:company]
    @job.salary        = params[:job][:salary]
    @job.location      = params[:job][:location]
    @job.description   = params[:job][:description]
    @job.hero_img      = params[:job][:hero_img]
    @job.logo_img      = params[:job][:logo_img]
    @job.tags          = params[:job][:tags]
    @job.source_url    = params[:job][:source_url]
    @job.source_id     = params[:job][:source_id]
    @job.source_domain = params[:job][:source_domain]
    @job.json          = params[:job][:json]
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