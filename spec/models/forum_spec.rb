require 'rails_helper'

RSpec.describe Forum, type: :model do
  context "when created or updated" do
    let(:forum) { FactoryBot.create(:forum) }

    it "is valid with required attributes" do
      expect(forum).to be_valid
    end

    it "is not valid without a title" do
      unnamed_forum = FactoryBot.build(:forum, title: nil)
      expect(unnamed_forum).to_not be_valid
    end

    it "is not valid when title is over 60 characters" do
      long_forum_title = FactoryBot.build(:forum,
                                          title: "I am a forum title over 60 characters long. Pretty long right?")
      expect(long_forum_title).to_not be_valid
    end

    it "is not valid when description is over 120 characters" do
      long_forum_description = FactoryBot.build(:forum,
                                                description: "I am a forum title over 120 characters long. Pretty long right? I am a forum title over 120 characters long. Pretty long right?")
      expect(long_forum_description).to_not be_valid
    end

    it "is not valid without a position" do
      positionless_forum = FactoryBot.build(:forum, position: nil)
      expect(positionless_forum).to_not be_valid
    end

    it "is not valid with a non-integer for position" do
      non_integer_position_forum = FactoryBot.build(:forum, position: "z")
      expect(non_integer_position_forum).to_not be_valid
    end

    it "generates an appropriately slugged friendlyId" do
      cool_forum = FactoryBot.create(:forum, title: "Cool Forum")
      expect(cool_forum.slug).to eq('cool-forum')
    end

    it "updates the slugged friendlyId on title change" do
      cool_forum = FactoryBot.create(:forum, title: "Cool Forum")
      cool_forum.update(title: "Coolest Forum")
      expect(cool_forum.slug).to eq("coolest-forum")
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
