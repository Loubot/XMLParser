class FavouritesController < ApplicationController

  def addFavourite
    @favourite = Favourite.create(name:params[:name], station:params[:code], user_id: current_user.id)
    if @favourite.save
      flash[:success] = 'Favourite saved'
      redirect_to station_info_path(:data => params[:code])
    else
      flash[:danger] = 'Failed to save favourite'
      redirect_to :back
    end
  end

  def destroy
    favourite = Favourite.find_by_id(params[:id])
    favourite.destroy
    flash[:success] = 'Favourite deleted'
    redirect_to :back
  end
end
