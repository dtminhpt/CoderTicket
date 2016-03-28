require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to(:venue) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:extended_html_description) }
  it { is_expected.to validate_presence_of(:venue) }
  it { is_expected.to validate_presence_of(:category) }
  it { is_expected.to validate_presence_of(:starts_at) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to([:venue_id, :starts_at]) }
  
  let(:event) { event = Event.new }

  describe "#venue_name" do
    it "returns nil if there's no venue" do
      expect(event.venue_name).to be_nil
    end

    it "returns venue's name if there's a venue" do
      event.venue = Venue.new(name: "RMIT")
      expect(event.venue_name).to eq "RMIT"
    end 
  end 
end
