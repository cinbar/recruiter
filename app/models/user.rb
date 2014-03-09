class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable 
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation , :remember_me 
  def to_s
   email
  end

  has_many :jobs
end
