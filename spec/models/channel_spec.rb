require 'rails_helper'

RSpec.describe Channel, type: :model do
  let(:channel) { FactoryBot.create(:channel) }

  it "is valid with a name" do
    expect(channel).to be_valid
  end

  it "is not valid without a name" do
    channel = Channel.new(name: nil)
    expect(channel).to_not be_valid
  end
end
