class Api::UsersController < ApplicationController
	skip_before_filter :authenticate_user!
	
	def create
		@user = User.new(params[:user])
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


end