class FavouritesController < ApplicationController
  def destroy
    favourite = Favourite.find_by_id(params[:id])
    favourite.destroy
    flash[:success] = 'Favourite deleted'
    redirect_to :back
  end
end
