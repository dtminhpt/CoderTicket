require 'rails_helper'

RSpec.describe "routing for root path", :type => :routing do
  it "routes / to events#index" do
    expect(:get => "/").to route_to(
      :controller => "events",
      :action => "index"
    )
  end

  it "does not expose a list of users" do
    expect(:get => "/users").not_to be_routable
  end
end