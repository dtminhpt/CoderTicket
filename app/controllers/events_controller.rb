class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :list, :publish]

  def index
    if params[:keyword].present?
      @events = Event.where('name LIKE ?', "%#{params[:keyword]}%")
    else
      @events = Event.where('starts_at >= ?', Date.today)
    end

  end

  def list
    @events = current_user.events 
  end 

  def publish
    @event = current_user.events.find(params[:id])

    if @event.ticket_types.count > 0
      @event.update_attributes!(published_at: Time.now)
      flash[:success] = 'The event has been published successfully.'
      redirect_to event_path(@event)
    else
      flash[:error] = 'Cannot publish an event without ticket types.'
      redirect_to event_path(@event)
    end
  end 

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new 
  end 

  def edit 
    @event = current_user.events.find(params[:id])
  end 

  def update 
    @events = current_user.events.find(params[:id])

    if @event.update_attributes(event_params)
      flash[:success] = 'The event has been updated successfully.'
      redirect_to event_path(@event)
    else
      render :edit
    end 
  end 

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      flash[:success] = 'The event has been created successfully.'
      redirect_to event_path(@event)
    else
      render :new
    end 
  end 

  private 
    def event_params
      params.require(:event).permit(:category_id, :venue_id, :name, :extended_html_description, :hero_image_url, :starts_at, :ends_at)
    end 

end
