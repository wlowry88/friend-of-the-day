class AddDetailsToFriends < ActiveRecord::Migration
  def change
    add_column :friends, :phone_number, :string
    add_column :friends, :email, :string
  end
end
