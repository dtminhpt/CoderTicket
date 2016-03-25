require 'rails_helper'

RSpec.describe Category, type: :model do
  context "validations" do
    it "checks for presence of name" do
      category = Category.new
      expect(category.save).to eq false
    end
  end
end
