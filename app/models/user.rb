class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :first_name, :last_name, :linkedin_user_id, :email, :password, :password_confirmation , :remember_me 
  def to_s
   email
  end

  has_many :jobs
end
