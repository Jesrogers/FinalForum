require 'rails_helper'

RSpec.describe "ForumThreads", type: :system do
  context "as a guest" do
    let!(:thread) { FactoryBot.create(:forum_thread, title: "This is a test thread", body: "Hello, please ignore this thread. It is being used for testing. Thanks!") }
    it "displays relevant thread content on show page" do
      visit root_path
      click_link "Forums"
      click_link(href: "/forums/#{thread.forum.slug}")

      expect(page).to have_text("This is a test thread")
      expect(page).to have_link(href: forum_thread_path(thread))

      click_link(href: "/threads/#{thread.slug}")

      expect(page).to have_text("Hello, please ignore this thread. It is being used for testing. Thanks!")
      expect(page).to have_text(thread.author.username)
      expect(page).to have_text(thread.author.created_at.strftime('%b %Y'))
      expect(page).to have_text(thread.created_at.strftime('%Y-%m-%d, %I:%M %p'))
    end

    # it "doesn't allow for threads to be created" do

    # end
  end

  context "as a logged in user" do
  end

  context "as a logged in admin" do
  end
end
