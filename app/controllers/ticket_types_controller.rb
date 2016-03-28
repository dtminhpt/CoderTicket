class TicketTypesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = current_user.events.find(params[:event_id])
    @ticket_type = @event.ticket_types.new
  end

  def create
    @event = current_user.events.find(params[:event_id])
    @ticket_type = @event.ticket_types.new(ticket_type_params)

    if @ticket_type.save
      flash[:success] = 'The ticket type has been created successfully.'
      redirect_to event_path(@event)
    else
      render :new 
    end 

  end 

  private
  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :max_quantity)
  end 

end
