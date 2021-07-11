require "rails_helper"

RSpec.describe "Forums", type: :system do
  context "as a guest" do
    it "displays child threads on show page" do
      forum = FactoryBot.create(:forum, :with_threads)

      visit root_path
      click_link "Forums"
      expect(page).to have_link(href: "/forums/#{forum.slug}")

      click_link(href: "/forums/#{forum.slug}")
      expect(page).to have_link(href: "/threads/#{forum.forum_threads[0].slug}")
      expect(page).to have_link(href: "/threads/#{forum.forum_threads[1].slug}")
    end
  end

  context "as a logged in user" do
    it "doesn't allow for forums to be created" do
      user = FactoryBot.create(:user)
      sign_in user

      visit root_path
      click_link "Forums"
      expect(page).to_not have_link("Add Forum", href: new_forum_path)

      visit new_forum_path
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for forums to be edited" do
      forum = FactoryBot.create(:forum, title: "Employees")
      user = FactoryBot.create(:user)

      sign_in user

      visit root_path
      click_link "Forums"
      expect(page).to_not have_link(href: "/forums/employees/edit")

      visit edit_forum_path(forum)
      expect(page).to have_text("403 Forbidden")
    end
  end

  context "as a logged in admin" do
    let(:admin) { FactoryBot.create(:user, :admin) }
    let!(:channel) { FactoryBot.create(:channel, name: "Employees") }

    it "allows for forums to be created" do
      sign_in admin

      visit root_path
      click_link "Forums"
      expect(page).to have_link(href: "#{new_forum_path}?channel=employees")

      click_link(href: "#{new_forum_path}?channel=employees")
      expect(page).to have_field("Title")
      expect(page).to have_field("Description")
      expect(page).to have_select("Channel", selected: "Employees")
      expect(page).to have_field("Position", with: 1)
      expect(page).to have_field("Locked")

      fill_in "Title", with: "General Discussion"
      fill_in "Description", with: "A place to talk about stuff"
      select "Employees", from: "Channel"
      fill_in "Position", with: 1
      click_button "Submit"

      expect(page).to have_current_path("/forums")
      within ".channel" do
        expect(page).to have_text(/General Discussion/i)
        expect(page).to have_text(/A place to talk about stuff/i)
        expect(page).to have_link(href: "/forums/general-discussion")
      end
    end

    it "allows for forums to be updated" do
      forum = FactoryBot.create(:forum, title: "General Discussion")

      sign_in admin

      visit root_path
      click_link "Forums"
      expect(page).to have_text(/Employees/i)
      expect(page).to have_link(href: "/forums/general-discussion")

      click_link(href: "/forums/general-discussion/edit")
      expect(page).to have_field("Title", with: "General Discussion")
      expect(page).to have_field("Description", with: "Talk about whatever you want here")
      expect(page).to have_select("Channel", selected: "Employee Area")
      expect(page).to have_field("Position", with: 1)
      expect(page).to have_unchecked_field("Locked")

      fill_in "Title", with: "Friends"
      fill_in "Description", with: "Talk about stuff here if you're a friend."
      fill_in "Position", with: 2
      check "Locked"
      click_button "Submit"

      expect(page).to have_current_path("/forums")
      expect(page).to have_text(/Friends/i)
      expect(page).to have_link(href: "/forums/friends")
      expect(page).to have_selector(".fa-lock")
    end

    it "allows for forums to be deleted" do
      forum = FactoryBot.create(:forum, title: "General Discussion")

      sign_in admin

      visit root_path
      click_link "Forums"

      within(".forum-card") do
        accept_confirm do
          find("[data-method='delete']").click()
        end
      end

      expect(page).to_not have_text(/General Discussion/i)
    end
  end
end
