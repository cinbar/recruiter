class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  attr_accessible :first_name, :last_name, :linked_in_id, :email, :password, :password_confirmation , :remember_me 
  def to_s
   email
  end

  has_many :jobs
end
