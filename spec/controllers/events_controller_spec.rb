require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the upcoming events into @events" do
      venue = Venue.create!(name: 'HCM Opera')
      category = Category.create!(name: 'Entertainment')
      attrs = { extended_html_description: 'extended_html_description', venue: venue, category: category }

      event1 = Event.create!(attrs.merge(name: 'Event 1', starts_at: 1.day.ago))
      event2 = Event.create!(attrs.merge(name: 'Event 2', starts_at: 1.day.from_now))

      get :index

      expect(assigns(:events)).to eq([event2])
    end
  end
end