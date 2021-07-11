require "rails_helper"

RSpec.describe Channel, type: :model do
  context "when created or updated" do
    it "is valid with a name" do
      channel = FactoryBot.build(:channel)
      expect(channel).to be_valid
    end

    it "is not valid without a name" do
      channel = Channel.new(name: nil)
      expect(channel).to_not be_valid
    end

    it "is not valid without a position" do
      channel = Channel.new(name: "New Channel", position: nil)
      expect(channel).to_not be_valid
    end

    it "is not valid when name is over 40 characters" do
      channel = Channel.new(name: "I am a channel name over 40 characters long")
      expect(channel).to_not be_valid
    end

    it "is not valid with a non-integer for position" do
      channel = Channel.new(name: "Employee Area", position: "z")
      expect(channel).to_not be_valid
    end

    it "generates an appropriately slugged friendlyId" do
      channel = FactoryBot.create(:channel)
      expect(channel.slug).to eq("employee-area")
    end

    it "updates the slugged friendlyId on name change" do
      channel = FactoryBot.create(:channel)
      channel.update(name: "Secret Channel")
      expect(channel.slug).to eq("secret-channel")
    end
  end

  context "when child forums are present" do
    let(:channel_with_forums) { FactoryBot.create(:channel, :with_forums) }

    it "adds child forums to the channel" do
      expect(channel_with_forums.forums.length).to eq(2)
    end

    it "destroys child forums when deleted" do
      expect { channel_with_forums.destroy }.to change { channel_with_forums.forums.count }.by(-2)
    end
  end

  context "when ordered" do
    let!(:channel) { FactoryBot.create(:channel) }

    it ".ordered_by_position sorts channels by position" do
      channel2 = Channel.create(name: "Second Channel", position: 0)
      expect(Channel.ordered_by_position[0]).to eql(channel2)
    end

    it ".ordered_by_position sorts alphabetically when positions are equal" do
      channel2 = Channel.create(name: "Zeta Channel", position: 1)
      expect(Channel.ordered_by_position[1]).to eql(channel2)
    end
  end
end
