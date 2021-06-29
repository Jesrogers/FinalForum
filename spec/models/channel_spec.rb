require 'rails_helper'

RSpec.describe Channel, type: :model do
  let!(:channel) { FactoryBot.create(:channel) }

  it "is valid with a name" do
    expect(channel).to be_valid
  end

  it "is not valid without a name" do
    unnamed_channel = Channel.new(name: nil)
    expect(unnamed_channel).to_not be_valid
  end

  it "is not valid without a position" do
    positionless_channel = Channel.new(name: "New Channel", position: nil)
    expect(positionless_channel).to_not be_valid
  end

  it "is not valid when name is over 40 characters" do
    long_channel = Channel.new(name: "I am a channel name over 40 characters long")
    expect(long_channel).to_not be_valid
  end

  it "is not valid with a non-integer for position" do
    integer_channel = Channel.new(name: "Employee Area", position: "z")
    expect(integer_channel).to_not be_valid
  end

  it "generates an appropriately slugged friendlyId" do
    expect(channel.slug).to eq("employee-area")
  end

  it "updates the slugged friendlyId on name change" do
    channel.update(name: "Secret Channel")
    expect(channel.slug).to eq("secret-channel")
  end

  it ".ordered_by_position sorts channels in a position-based order" do
    channel2 = Channel.create(name: "Second Channel", position: 0)
    expect(Channel.ordered_by_position[0]).to eql(channel2)
  end

  it ".ordered_by_position sorts alphabetically when positions are equal" do
    channel2 = Channel.create(name: "Zeta Channel", position: 1)
    expect(Channel.ordered_by_position[0]).to eql(channel)
  end
end
