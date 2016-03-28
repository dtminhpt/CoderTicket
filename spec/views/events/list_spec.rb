require 'rails_helper'

RSpec.describe "events/list", type: :view do
  before do 
    venue = Venue.create!(name: 'HCM Opera')
    category = Category.create!(name: 'Entertainment')
    attrs = { extended_html_description: 'extended_html_description', venue: venue, category: category, published_at: 3.days.ago }

    @event1 = Event.create!(attrs.merge(name: 'Random event 1', starts_at: 1.day.ago))
    @event2 = Event.create!(attrs.merge(name: 'Event 2', starts_at: 1.day.from_now))
    @event2.ticket_types.create!
  end 

  it "displays event details correctly" do
    assign(:events, [@event1])

    render

    expect(rendered).to include('Random event 1')
  end

   it "asks for creating ticket types before publishing" do
    assign(:events, [@event1])

    render

    expect(rendered).to include('Create ticket types')
    expect(rendered).to_not include('Publish event')
  end

  it "allows event with creating ticket types to be published" do
    assign(:events, [@event2])

    render

    expect(rendered).to_not include('Create ticket types')
    expect(rendered).to include('Publish event')
  end


end

