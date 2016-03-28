class TicketsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])

    if @event.ends_at.try(:past?)
      flash[:warning] = "You cannot buy tickets of past events."
      redirect_to event_path(@event)
    else
      @tickets = Ticket.where(user: current_user, event: @event)
    end
  end

  def create
    @event = Event.find(params[:event_id])
    params[:type_quantities].each do |type_id, quantity|
      Ticket.create!(user: current_user, event: @event, ticket_type_id: type_id, quantity: quantity) if quantity.to_i > 0
    end
    flash[:success] = "Thank you for buying the event tickets."
    redirect_to event_path(@event)
  end
end
