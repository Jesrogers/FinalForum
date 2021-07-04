require 'rails_helper'
require './spec/support/forum_helper'
require './spec/support/cke_helper'

RSpec.describe "ForumThreads", type: :system do
  context "as a guest" do
    it "displays relevant thread content on show page" do
      thread = FactoryBot.create(:forum_thread, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      go_to_forum(thread.forum)
      expect(page).to have_text("This is a test thread")
      expect(page).to have_link(href: forum_thread_path(thread))

      click_link(href: "/threads/#{thread.slug}")

      expect(page).to have_text("Hello, please ignore this thread. It is being used for testing. Thanks!")
      expect(page).to have_text(thread.author.username)
      expect(page).to have_text(thread.author.created_at.strftime('%b %Y'))
      expect(page).to have_text(thread.created_at.strftime('%Y-%m-%d, %I:%M %p'))
    end

    it "doesn't allow for threads to be created" do
      forum = FactoryBot.create(:forum)

      go_to_forum(forum)
      expect(page).to_not have_link("New Thread", href: new_forum_forum_thread_path(forum))

      visit new_forum_forum_thread_path(forum)
      expect(page).to have_current_path("/login")
      expect(page).to have_text("Login")
    end
  end

  context "as a logged in user" do
    let(:user) { FactoryBot.create(:user) }
    let(:forum) { FactoryBot.create(:forum) }
    let(:locked_forum) { FactoryBot.create(:forum, :locked) }

    it "allows for threads to be created when forum is unlocked" do
      sign_in user
      go_to_forum(forum)
      expect(page).to have_link("New Thread", href: new_forum_forum_thread_path(forum.id))

      visit new_forum_forum_thread_path(forum)
      expect(page).to have_field("Title")
      expect(page).to have_css("#cke_forum_thread_body")

      fill_in "Title", with: "I am a brand new thread!"
      fill_in_ckeditor('forum_thread_body', with: "I like long walks on the beach")
      click_button "Submit"

      expect(page).to have_current_path("/threads/i-am-a-brand-new-thread")
      expect(page).to have_text("I am a brand new thread!")
      expect(page).to have_text("I like long walks on the beach")
    end

    it "allows for editing of own threads when forum and thread are unlocked" do
      thread = FactoryBot.create(:forum_thread, author: user, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(thread.forum)
      click_link(href: forum_thread_path(thread))
      expect(page).to have_link("Edit", href: edit_forum_thread_path(thread))

      click_link("Edit", href: edit_forum_thread_path(thread))
      expect(page).to have_field("Title", with: "This is a test thread")
      expect(get_ckeditor_text("forum_thread_body")).to eq("Hello, please ignore this thread. It is being used for testing. Thanks!")

      fill_in("Title", with: "This is a totally real thread")
      fill_in_ckeditor("forum_thread_body", with: "Don't ignore me please. It will hurt my feelings.")
      click_button("Submit")

      thread.reload
      expect(page).to have_current_path(forum_thread_path(thread))
      expect(page).to have_text("This is a totally real thread")
      expect(page).to have_text("Don't ignore me please. It will hurt my feelings.")
    end

    it "allows for deletion of own thread when forum and thread are unlocked" do
      thread = FactoryBot.create(:forum_thread, author: user, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(thread.forum)
      click_link(href: forum_thread_path(thread))
      expect(page).to have_link("Delete", href: forum_thread_path(thread))

      accept_confirm do
        click_link("Delete", href: forum_thread_path(thread))
      end

      expect(page).to have_current_path(forum_path(thread.forum))
      expect(page).to_not have_text("This is a test thread")
    end

    it "doesn't allow for the editing of another's thread" do
      user2 = FactoryBot.create(:user)
      thread = FactoryBot.create(:forum_thread, author: user2, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(thread.forum)
      click_link(href: forum_thread_path(thread))
      expect(page).to_not have_link("Edit", href: forum_thread_path(thread))

      visit edit_forum_thread_path(thread)
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for thread creation when forum is locked" do
      thread = FactoryBot.create(:forum_thread, forum: locked_forum, author: user, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(locked_forum)
      expect(page).to have_text("This forum is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_link("New Thread", href: new_forum_forum_thread_path(locked_forum))

      visit new_forum_forum_thread_path(locked_forum)
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for editing of own threads when forum is locked" do
      thread = FactoryBot.create(:forum_thread, forum: locked_forum, author: user, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(locked_forum)
      click_link(href: forum_thread_path(thread))
      expect(page).to have_text("This forum is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_link("Edit", href: forum_thread_path(thread))

      visit edit_forum_thread_path(thread)
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for deletion of own thread when forum is locked" do
      thread = FactoryBot.create(:forum_thread, forum: locked_forum, author: user, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(locked_forum)
      click_link(href: forum_thread_path(thread))
      expect(page).to have_text("This forum is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_link("Delete", href: forum_thread_path(thread))
    end

    it "doesn't allow for editing of own thread when thread is locked" do
      locked_thread = FactoryBot.create(:forum_thread, :locked, author: user, title: "This is a test thread",
                                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(locked_thread.forum)
      click_link(href: forum_thread_path(locked_thread))

      expect(page).to have_text("This thread is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_link("Edit", href: forum_thread_path(locked_thread))

      visit edit_forum_thread_path(locked_thread)
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for deletion of own thread when thread is locked" do
      locked_thread = FactoryBot.create(:forum_thread, :locked, author: user, title: "This is a test thread",
                                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(locked_thread.forum)
      click_link(href: forum_thread_path(locked_thread))

      expect(page).to have_text("This thread is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_link("Delete", href: forum_thread_path(locked_thread))
    end

    it "renders new page with validation errors" do
      sign_in user
      go_to_forum(forum)
      expect(page).to have_link("New Thread", href: new_forum_forum_thread_path(forum.id))

      click_link("New Thread", href: new_forum_forum_thread_path(forum.id))

      fill_in "Title",
              with: "I am a brand new thread! I am a brand new thread! I am a brand new thread! I am a brand new thread! Hello!"
      fill_in_ckeditor('forum_thread_body', with: "Hello")
      click_button "Submit"

      expect(page).to have_text("Title is too long (maximum is 100 characters)")
      expect(page).to have_text("Body is too short (minimum is 20 characters)")
    end

    it "renders edit page with validation errors" do
      thread = FactoryBot.create(:forum_thread, author: user, title: "This is a test thread",
                                                body: "Hello, please ignore this thread. It is being used for testing. Thanks!")

      sign_in user
      go_to_forum(thread.forum)
      click_link(href: forum_thread_path(thread))
      expect(page).to have_link("Edit", href: edit_forum_thread_path(thread))

      click_link("Edit", href: edit_forum_thread_path(thread))
      fill_in("Title",
              with: "I am a brand new thread! I am a brand new thread! I am a brand new thread! I am a brand new thread! Hello!")
      fill_in_ckeditor("forum_thread_body", with: "Ignore")
      click_button("Submit")

      expect(page).to have_text("Title is too long (maximum is 100 characters)")
      expect(page).to have_text("Body is too short (minimum is 20 characters)")
    end
  end

  context "as a logged in admin" do
    let(:admin_user) { FactoryBot.create(:user, :admin) }
    let(:forum) { FactoryBot.create(:forum) }
    let(:locked_forum) { FactoryBot.create(:forum, :locked) }

    it "allows for threads to be created when forum is unlocked" do
      sign_in admin_user
      go_to_forum(forum)

      expect(page).to have_link("New Thread", href: new_forum_forum_thread_path(forum.id))

      visit new_forum_forum_thread_path(forum)
      expect(page).to have_field("Title")
      expect(page).to have_css("#cke_forum_thread_body")

      fill_in "Title", with: "I am a brand new thread!"
      fill_in_ckeditor('forum_thread_body', with: "I like long walks on the beach")
      click_button "Submit"

      expect(page).to have_current_path("/threads/i-am-a-brand-new-thread")
      expect(page).to have_text("I am a brand new thread!")
      expect(page).to have_text("I like long walks on the beach")
    end

    it "allows for threads to be created when forum is locked" do
      sign_in admin_user
      go_to_forum(locked_forum)

      expect(page).to have_text("This forum is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to have_link("New Thread", href: new_forum_forum_thread_path(locked_forum.id))

      visit new_forum_forum_thread_path(forum)
      expect(page).to have_field("Title")
      expect(page).to have_css("#cke_forum_thread_body")

      fill_in "Title", with: "I am a brand new thread!"
      fill_in_ckeditor('forum_thread_body', with: "I like long walks on the beach")
      click_button "Submit"

      expect(page).to have_current_path("/threads/i-am-a-brand-new-thread")
      expect(page).to have_text("I am a brand new thread!")
      expect(page).to have_text("I like long walks on the beach")
    end
  end
end
