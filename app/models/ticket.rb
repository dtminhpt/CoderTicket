class Ticket < ActiveRecord::Base
  belongs to :user
  belongs to :event
  belongs to :ticket_type
end
