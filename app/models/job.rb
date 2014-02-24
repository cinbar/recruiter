class Job < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :company, :salary, :location, :description,
  				  :hero_img, :logo_img, :tags
end