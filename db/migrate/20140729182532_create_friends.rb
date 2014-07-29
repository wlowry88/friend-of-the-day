class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.datetime :birthday
      t.references :user, index: true

      t.timestamps
    end
  end
end
