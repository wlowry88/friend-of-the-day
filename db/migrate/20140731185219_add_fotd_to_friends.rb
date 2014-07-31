class AddFotdToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :fotd, :boolean, :default => false
  end
end
