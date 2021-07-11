require "rails_helper"

RSpec.describe ForumReply, type: :model do
  context "when created or updated" do
    it "is valid with a body" do
      reply = FactoryBot.build(:forum_reply)
      expect(reply).to be_valid
    end

    it "is invalid without a body" do
      reply = FactoryBot.build(:forum_reply, body: "")
      expect(reply).to be_invalid
    end

    it "is invalid when the body is under 20 characters" do
      reply = FactoryBot.build(:forum_reply, body: "Short reply")
      expect(reply).to be_invalid
    end

    it "is invalid when the body is over 20000 characters" do
      reply = FactoryBot.build(:forum_reply, body: SecureRandom.hex(20001))
      expect(reply).to be_invalid
    end

    it "generates an appropriately slugged friendlyId" do
      reply = FactoryBot.create(:forum_thread, title: "Cool reply")
      expect(reply.slug).to eq("cool-reply")
    end

    it "updates the slugged friendlyId on body change" do
      reply = FactoryBot.create(:forum_thread, title: "Cool reply")
      reply.update(title: "Coolest reply")
      expect(reply.slug).to eq("coolest-reply")
    end
  end
end
