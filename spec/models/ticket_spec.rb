require 'rails_helper'

RSpec.describe Ticket, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:event) }
  it { is_expected.to belong_to(:ticket_type) }
end
