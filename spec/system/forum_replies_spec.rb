require 'rails_helper'
require './spec/support/forum_thread_helper'
require './spec/support/cke_helper'

RSpec.describe "ForumReplies", type: :system do
  let(:thread) { FactoryBot.create(:forum_thread) }
  let(:thread_with_replies) { FactoryBot.create(:forum_thread, :with_replies) }
  context "as a guest" do
    it "doesn't show reply form on an unlocked thread" do
      go_to_forum_thread(thread)
      expect(page).to_not have_css("#cke_forum_reply_body")
    end

    it "displays relevant replies on thread show page" do
      go_to_forum_thread(thread_with_replies)
      expect(page).to have_text(thread_with_replies.forum_replies[0].body)
      expect(page).to have_text(thread_with_replies.forum_replies[1].body)
    end
  end

  context "as a logged in user" do
    let(:user) { FactoryBot.create(:user) }
    let(:thread) { FactoryBot.create(:forum_thread) }
    let(:locked_forum) { FactoryBot.create(:forum, :locked) }
    let(:locked_thread) { FactoryBot.create(:forum_thread, :locked)}
    let(:locked_thread_locked_forum) { FactoryBot.create(:forum_thread, :locked, forum: locked_forum) }

    it "allows for replies to be created when forum and thread are unlocked" do
      sign_in user
      go_to_forum_thread(thread)
      expect(page).to have_css("#cke_forum_reply_body")

      fill_in_ckeditor('forum_reply_body', with: "Hello, nice to meet you!")
      click_button "Submit"

      expect(page).to have_current_path(forum_thread_path(thread))
      expect(page).to have_text("Hello, nice to meet you!")
    end

    it "allows for editing of own replies when forum and thread are unlocked" do
      reply = FactoryBot.create(:forum_reply, author: user, body: "This is a test reply!")

      sign_in user
      go_to_forum_thread(reply.forum_thread)
      expect(page).to have_link(href: edit_forum_reply_path(reply))

      click_link(href: edit_forum_reply_path(reply))
      expect(page).to have_text("Edit Reply")
      expect(get_ckeditor_text("forum_reply_body")).to eq("This is a test reply!")

      fill_in_ckeditor('forum_reply_body', with: "I am an edited reply!")
      click_button("Submit")

      expect(page).to have_current_path(forum_thread_path(reply.forum_thread))
      expect(page).to have_text("I am an edited reply!")
    end

    it "allows for deletion of own reply when forum and thread are unlocked" do
      reply = FactoryBot.create(:forum_reply, author: user)

      sign_in user
      go_to_forum_thread(reply.forum_thread)
      expect(page).to have_link(href: forum_reply_path(reply))

      accept_confirm do
        click_link(href: forum_reply_path(reply))
      end

      expect(page).to have_current_path(forum_thread_path(reply.forum_thread))
      expect(page).to_not have_text(reply.body)
    end

    it "doesn't allow for the editing of another's reply" do
      user2 = FactoryBot.create(:user)
      reply = FactoryBot.create(:forum_reply, author: user2)

      sign_in user
      go_to_forum_thread(reply.forum_thread)
      expect(page).to_not have_link(href: edit_forum_reply_path(reply))

      visit edit_forum_reply_path(reply)
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for reply creation when forum is locked" do
      thread = FactoryBot.create(:forum_thread, forum: locked_forum)

      sign_in user
      go_to_forum_thread(thread)
      
      expect(page).to have_text("This forum is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_css("#cke_forum_reply_body")
    end

    it "doesn't allow for editing of own replies when forum is locked" do
      reply = FactoryBot.create(:forum_reply, forum_thread: locked_thread_locked_forum, author: user)

      sign_in user
      go_to_forum_thread(locked_thread_locked_forum)
      expect(page).to have_text("This forum is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_link(href: edit_forum_reply_path(reply))
      
      visit edit_forum_reply_path(reply)
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for editing of own reply when thread is locked" do
      reply = FactoryBot.create(:forum_reply, forum_thread: locked_thread, author: user)

      sign_in user
      go_to_forum_thread(locked_thread)
      expect(page).to have_text("This thread is locked. Feel free to browse, but interaction is disabled.")
      expect(page).to_not have_link(href: edit_forum_reply_path(reply))

      visit edit_forum_reply_path(reply)
      expect(page).to have_text("403 Forbidden")
    end
  end

  context "as a logged in admin" do
    let(:admin_user) { FactoryBot.create(:user, :admin) }
    let(:user) { FactoryBot.create(:user) }
    let(:thread) { FactoryBot.create(:forum_thread) }
    let(:locked_forum) { FactoryBot.create(:forum, :locked) }
    let(:locked_thread) { FactoryBot.create(:forum_thread, :locked)}
    let(:locked_thread_locked_forum) { FactoryBot.create(:forum_thread, :locked, forum: locked_forum) }

    it "allows for replies to be created when thread is locked" do
      sign_in admin_user
      go_to_forum_thread(locked_thread)
      expect(page).to have_css("#cke_forum_reply_body")

      fill_in_ckeditor('forum_reply_body', with: "Hello, nice to meet you!")
      click_button "Submit"

      expect(page).to have_current_path(forum_thread_path(locked_thread))
      expect(page).to have_text("Hello, nice to meet you!")
    end

    it "allows for editing of own replies when forum and thread are locked" do
      reply = FactoryBot.create(:forum_reply, author: admin_user, forum_thread: locked_thread_locked_forum, body: "This is a test reply!")

      sign_in admin_user
      go_to_forum_thread(reply.forum_thread)
      expect(page).to have_link(href: edit_forum_reply_path(reply))

      click_link(href: edit_forum_reply_path(reply))
      expect(page).to have_text("Edit Reply")
      expect(get_ckeditor_text("forum_reply_body")).to eq("This is a test reply!")

      fill_in_ckeditor('forum_reply_body', with: "I am an edited reply!")
      click_button("Submit")

      expect(page).to have_current_path(forum_thread_path(reply.forum_thread))
      expect(page).to have_text("I am an edited reply!")
    end

    it "allows for deletion of own reply when forum is locked" do
      thread = FactoryBot.create(:forum_thread, :locked, forum: locked_forum)
      reply = FactoryBot.create(:forum_reply, forum_thread: thread, author: user)

      sign_in admin_user
      go_to_forum_thread(thread)
      expect(page).to have_link(href: forum_reply_path(reply))

      accept_confirm do
        click_link(href: forum_reply_path(reply))
      end

      expect(page).to have_current_path(forum_thread_path(reply.forum_thread))
      expect(page).to_not have_text(reply.body)
    end
  end
end
