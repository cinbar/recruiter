class Api::UsersController < ApplicationController
	skip_before_filter :authenticate_user!
	
	def index
		@users = User.all.paginate(:page => params[:page])
		render json: @users
	end

	def create
		@user = User.new(params[:user])
		if params[:user][:uid] != nil
			@user.linkedin_user_id = params[:user][:uid]
		end 
		begin
		  @user.save!
		  render json: @user
		rescue Exception => ex
		  render json: "Api::UsersController: Error: #{ex.message}"
		end
		
	end

	def show 
		@user = User.find(params[:id])
		@user.to_json
		render json: @user
	end

	def update
		@user = User.find(params[:user][:id])
		@user.update_attributes(params[:user])
		@user.save!
		render json: @user
	end

	def destroy 
		@user = User.find(params[:id])
		begin
		  @user.destroy!
		  head :success
		rescue Exception => ex
		  render json: "Api::UsersController: error: #{ex.message}"
	    end

	end


end