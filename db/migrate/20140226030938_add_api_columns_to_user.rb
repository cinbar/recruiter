# make iOS user model match mysql
class AddApiColumnsToUser < ActiveRecord::Migration
	def up 
		add_column :users ,:is_recruiter, :bool
		add_column :users ,:linkedin_token, :string
		add_column :users ,:image_url, :string
		add_column :users ,:location, :string
		add_column :users ,:latitude, :string
		add_column :users ,:longitude, :string
		add_column :users ,:education_school, :string
		add_column :users ,:education_degree, :string
		add_column :users ,:industry, :string
		add_column :users ,:first_job, :string
		add_column :users ,:skills, :text, limit: 4294967295
		
	end
	def down
		remove_column :users ,:is_recruiter, :bool
		remove_column :users ,:linkedin_token, :string
		remove_column :users ,:image_url, :string
		remove_column :users ,:location, :string
		remove_column :users ,:latitude, :string
		remove_column :users ,:longitude, :string
		remove_column :users ,:education_school, :string
		remove_column :users ,:education_degree, :string
		remove_column :users ,:industry, :string
		remove_column :users ,:first_job, :string
		remove_column :users ,:skills, :text, limit: 4294967295	
	end
end
