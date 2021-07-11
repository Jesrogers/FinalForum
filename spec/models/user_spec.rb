require "rails_helper"

RSpec.describe User, type: :model do
  context "when created or updated" do
    it "is valid with an email, username, and password" do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it "is invalid when email is missing" do
      user = FactoryBot.build(:user, email: "")
      expect(user).to be_invalid
    end

    it "is invalid when email has already been taken" do
      user = FactoryBot.create(:user, email: "awesomeemail@example.com")
      user2 = FactoryBot.build(:user, email: "awesomeemail@example.com")
      expect(user2).to be_invalid
    end

    it "is invalid when username is missing" do
      user = FactoryBot.build(:user, username: "")
    end

    it "is invalid when username is over 30 chars" do
      user = FactoryBot.build(:user, username: "ThisIsQuiteTheLongUsernameIndeed")
      expect(user).to be_invalid
    end

    it "is invalid when a username has already been taken (case insensitive)" do
      user = FactoryBot.create(:user, username: "Freddy")
      user2 = FactoryBot.build(:user, username: "freddy")
      expect(user2).to be_invalid
    end

    it "is invalid when biography is over 1200 chars" do
      user = FactoryBot.build(:user, biography: SecureRandom.hex(1201))
      expect(user).to_not be_valid
    end

    it "generates an appropriately slugged friendlyId" do
      user = FactoryBot.create(:user, username: "Freaky Freddy")
      expect(user.slug).to eq("freaky-freddy")
    end

    it "updates the slugged friendlyId on title change" do
      user = FactoryBot.create(:user, username: "Freaky Freddy")
      user.update(username: "Friendly Freddy")
      expect(user.slug).to eq("friendly-freddy")
    end
  end

  context "when authoring threads" do
    let(:user_with_threads) { FactoryBot.create(:user, :with_threads) }

    it "adds threads to the user" do
      expect(user_with_threads.forum_threads.length).to eq(2)
    end
  end
end
