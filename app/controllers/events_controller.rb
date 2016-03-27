class EventsController < ApplicationController
  def index
    
    if params[:keyword].present?
      @events = Event.where('name LIKE ?', "%{params[:keyword]}%")
    else
      @events = Event.where('starts_at >= ?', Date.today)
    end

  end

  def show
    @event = Event.find(params[:id])
  end
end
