require "rails_helper"

RSpec.describe ForumThread, type: :model do
  context "when created or updated" do
    it "is valid with a title and body" do
      thread = FactoryBot.build(:forum_thread)
      expect(thread).to be_valid
    end

    it "is invalid without a title" do
      thread = FactoryBot.build(:forum_thread, title: "")
      expect(thread).to be_invalid
    end

    it "is invalid when title is over 100 characters" do
      thread = FactoryBot.build(:forum_thread, title: SecureRandom.hex(101))
      expect(thread).to be_invalid
    end

    it "is invalid without a body" do
      thread = FactoryBot.build(:forum_thread, body: "")
      expect(thread).to be_invalid
    end

    it "is invalid when body is under 20 characters" do
      thread = FactoryBot.build(:forum_thread, body: "Short body")
      expect(thread).to be_invalid
    end

    it "is invalid when body is over 20000 characters" do
      thread = FactoryBot.build(:forum_thread, title: SecureRandom.hex(20001))
      expect(thread).to be_invalid
    end

    it "generates an appropriately slugged friendlyId" do
      thread = FactoryBot.create(:forum_thread, title: "Cool Thread")
      expect(thread.slug).to eq("cool-thread")
    end

    it "updates the slugged friendlyId on title change" do
      thread = FactoryBot.create(:forum_thread, title: "Cool Thread")
      thread.update(title: "Coolest Thread")
      expect(thread.slug).to eq("coolest-thread")
    end
  end

  context "when child replies are present" do
    let(:forum_with_replies) { FactoryBot.create(:forum_thread, :with_replies) }

    it "adds replies to the thread" do
      expect(forum_with_replies.forum_replies.length).to eq(2)
    end

    it "destroys child threads when deleted" do
      expect { forum_with_replies.destroy }.to change { forum_with_replies.forum_replies.count }.by(-2)
    end
  end
end
