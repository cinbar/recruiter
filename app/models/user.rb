class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  attr_accessible :first_name, :last_name, :linked_in_id, :email, :password, :password_confirmation , :remember_me 
  def to_s
   email
  end
  
  def self.find_by_linked_in_id(id)
    begin
      self.find_by! linked_in_id: id
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end
    

  has_many :jobs
end
