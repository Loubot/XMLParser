class AddNameToFavourites < ActiveRecord::Migration
  def change
    add_column :favourites, :name, :string
  end
end
