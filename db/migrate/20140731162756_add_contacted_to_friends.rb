class AddContactedToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :contacted, :boolean, :default => false
  end
end
