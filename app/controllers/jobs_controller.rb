class JobsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:create, :show, :index, :api_index]
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
      if @job.update_attributes(params[:job])
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
    @job = Job.new
    #@job.title         = params[:job][:title]
    @job.position      = params[:job][:position]
    @job.company       = params[:job][:company]
    @job.salary        = params[:job][:salary]
    @job.location      = params[:job][:location]
    @job.description   = params[:job][:description]
    @job.hero_img      = params[:job][:hero_img]
    @job.logo_img      = params[:job][:logo_img]
    @job.tags          = params[:job][:tags]
    @job.updated       = params[:job][:updated]
    @job.owner         = current_user.id if current_user
    #@job.source_url    = params[:job][:source_url]
    #@job.source_id     = params[:job][:source_id]
    #@job.source_domain = params[:job][:source_domain]
    #@job.user_id = current_user.id if current_user
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
  def api_index
    len = params[:limit] || 300
    @jobs = Job.order("created_at DESC").limit(len)
    respond_to do |format|
      format.json { render json: @jobs}
    end
  end
  def index
    #@jobs = Job.order("created_at DESC").paginate(:page => params[:page])
    @jobs = Job.paginate(:page => params[:page])
    @job_count = Job.count
    respond_to do |format|
      format.html {render :index} 
      format.json {render json: @jobs}
    end
  end
end