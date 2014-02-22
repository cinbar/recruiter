class Job < ActiveRecord::Base
  belongs_to :user
  
  attr_accessor :title, :json, :source_url, :source_id, :source_domain
end