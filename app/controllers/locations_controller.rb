class LocationsController < ApplicationController
  def create
    @user = User.find params[:id]
    @location = Location.new params.require(:location).permit(:latitude, :longitude)
    @location.user = @user

    if @location.save
      redirect_to user_path(@user)
    else
      render "users/show"
    end
  end
end
