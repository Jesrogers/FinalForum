require "rails_helper"

RSpec.describe Forum, type: :model do
  context "when created or updated" do
    it "is valid with required attributes" do
      forum = FactoryBot.create(:forum)
      expect(forum).to be_valid
    end

    it "is not valid without a title" do
      forum = FactoryBot.build(:forum, title: nil)
      expect(forum).to_not be_valid
    end

    it "is not valid when title is over 60 characters" do
      forum = FactoryBot.build(:forum, title: SecureRandom.hex(61))
      expect(forum).to_not be_valid
    end

    it "is not valid when description is over 120 characters" do
      forum = FactoryBot.build(:forum, description: SecureRandom.hex(121))
      expect(forum).to_not be_valid
    end

    it "is not valid without a position" do
      forum = FactoryBot.build(:forum, position: nil)
      expect(forum).to_not be_valid
    end

    it "is not valid with a non-integer for position" do
      forum = FactoryBot.build(:forum, position: "z")
      expect(forum).to_not be_valid
    end

    it "generates an appropriately slugged friendlyId" do
      forum = FactoryBot.create(:forum, title: "Cool Forum")
      expect(forum.slug).to eq("cool-forum")
    end

    it "updates the slugged friendlyId on title change" do
      forum = FactoryBot.create(:forum, title: "Cool Forum")
      forum.update(title: "Coolest Forum")
      expect(forum.slug).to eq("coolest-forum")
    end
  end

  context "when child threads are present" do
    let(:forum_with_threads) { FactoryBot.create(:forum, :with_threads) }

    it "adds child threads to the forum" do
      expect(forum_with_threads.forum_threads.length).to eq(2)
    end

    it "destroys child threads when deleted" do
      expect { forum_with_threads.destroy }.to change { forum_with_threads.forum_threads.count }.by(-2)
    end
  end

  context "when ordered" do
    let!(:forum) { FactoryBot.create(:forum) }

    it ".ordered_by_position sorts channels by position" do
      forum2 = FactoryBot.create(:forum, position: 0)
      expect(Forum.ordered_by_position[0]).to eql(forum2)
    end

    it ".ordered_by_position sorts alphabetically when positions are equal" do
      forum2 = FactoryBot.create(:forum, title: "Zeta Forum")
      expect(Forum.ordered_by_position[1]).to eql(forum2)
    end
  end
end
