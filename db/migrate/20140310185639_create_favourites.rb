class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.string :station
      t.integer :user_id

      t.timestamps
    end
  end
end
