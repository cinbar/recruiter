class Job < ActiveRecord::Base
  self.table_name = "api_jobs"
  belongs_to :user, :foreign_key => :owner
  # attr_accessible :title, :company, :salary, :location, :description,
  # 				  :hero_img, :logo_img, :tags
  attr_accessible :position, :hero_img, :logo_img, :location, :salary, :updated, 
  				  :skill_ids, :company, :tags, :description, :owner
end