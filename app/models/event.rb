class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category

  belongs_to :user
  
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, scope: [:venue_id, :starts_at]

  def venue_name
    if venue
      venue.name
    else
      nil
    end 
  end 

end
