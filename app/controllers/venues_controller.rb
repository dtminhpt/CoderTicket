class VenuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new 
  end

  def create
    @venue = Venue.new(venue_params)

    if @venue.save
      flash[:success] = 'The venue has been created successfully.'
      redirect_to venues_path
    else
      render :new
    end 
  end 

  private
  def venue_params
    params.require(:venue).permit(:region_id, :name, :full_address)
  end
end
