class FavouritesController < ApplicationController

  def addFavourite
    @favourite = Favourite.new(name:params[:name], station:params[:code], user_id: current_user.id)
    if @favourite.save
      flash[:success] = 'Favourite saved'
      redirect_to :back
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
