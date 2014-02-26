class AddLinkedInUserToModel < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_user_id, :string
  end
end
