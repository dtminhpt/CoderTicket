class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    
    if params[:keyword].present?
      @events = Event.where('name LIKE ?', "%#{params[:keyword]}%")
    else
      @events = Event.where('starts_at >= ?', Date.today)
    end

  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new 
  end 

  

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      flash[:success] = 'The event has been created successfully.'
      redirect_to root_path
    else
      render :new
    end 
  end 

  private 
    def event_params
      params.require(:event).permit(:category_id, :venue_id, :name, :extended_html_description, :hero_image_url, :starts_at, :ends_at)
    end 

end
