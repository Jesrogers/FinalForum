require 'rails_helper'

RSpec.describe "Channels", type: :system do
  context "as a guest" do
    it "doesn't allow for channels to be created" do
      visit root_path
      click_link "Forums"
      expect(page).to_not have_link("Create Channel", href: new_channel_path)

      visit new_channel_path
      expect(page).to have_current_path("/login")
    end

    it "doesn't allow for channels to be updated" do
      channel = FactoryBot.create(:channel, name: "Employees")

      visit root_path
      click_link "Forums"
      expect(page).to have_text(/Employees/i)
      expect(page).to have_link(href: "/channels/employees")
      expect(page).to_not have_link(href: "/channels/employees/edit")

      visit edit_channel_path(channel)

      expect(page).to have_current_path("/login")
    end

    it "displays child forums on show page" do
      channel = FactoryBot.create(:channel, name: "Employees")
      forum = FactoryBot.create(:forum, title: "General Discussion", channel: channel)

      visit root_path
      click_link "Forums"
      expect(page).to have_link(href: "/forums/general-discussion")

      click_link(href: "/channels/employees")
      expect(page).to have_current_path("/channels/employees")
      expect(page).to have_link("Employees", href: "/channels/employees")
      expect(page).to have_link(href: "/forums/general-discussion")
    end
  end

  context "as a logged in user" do
    it "doesn't allow for channels to be created" do
      user = FactoryBot.create(:user)
      sign_in user

      visit root_path
      click_link "Forums"
      expect(page).to_not have_link("Create Channel", href: new_channel_path)

      visit new_channel_path
      expect(page).to have_text("403 Forbidden")
    end

    it "doesn't allow for channels to be edited" do
      channel = FactoryBot.create(:channel, name: "Employees")
      user = FactoryBot.create(:user)

      sign_in user

      visit root_path
      click_link "Forums"
      expect(page).to_not have_link(href: "/channels/employees/edit")

      visit edit_channel_path(channel)
      expect(page).to have_text("403 Forbidden")
    end
  end

  context "as a logged in admin" do
    let(:admin) { FactoryBot.create(:user, :admin) }

    it "allows for channels to be created" do
      sign_in admin

      visit root_path
      click_link "Forums"
      expect(page).to have_link("Create Channel", href: new_channel_path)

      click_link "Create Channel"
      expect(page).to have_field("Name")
      expect(page).to have_field("Position")

      fill_in "Name", with: "Employees"
      fill_in "Position", with: 1
      click_button "Submit"

      expect(page).to have_current_path("/forums")
      expect(page).to have_text(/Employees/i)
      expect(page).to have_link(href: "/channels/employees")
    end

    it "renders new page with validation errors" do
      sign_in admin

      visit root_path
      click_link "Forums"

      click_link "Create Channel"

      fill_in "Name", with: "I am a channel name over 40 characters long"
      fill_in "Position", with: 1
      click_button "Submit"

      expect(page).to have_text("Name is too long")
    end

    it "allows for channels to be updated" do
      channel = FactoryBot.create(:channel, name: "Employees")

      sign_in admin

      visit root_path
      click_link "Forums"
      expect(page).to have_text(/Employees/i)
      expect(page).to have_link(href: "/channels/employees")

      click_link(href: "/channels/employees/edit")
      expect(page).to have_field("Name", with: "Employees")
      expect(page).to have_field("Position", with: 1)

      fill_in "Name", with: "Guests"
      fill_in "Position", with: 2
      click_button "Submit"

      expect(page).to have_current_path("/forums")
      expect(page).to have_text(/Guests/i)
      expect(page).to have_link(href: "/channels/guests")
    end

    it "renders edit page with validation errors" do
      channel = FactoryBot.create(:channel, name: "Employees")

      sign_in admin

      visit root_path
      click_link "Forums"

      click_link(href: "/channels/employees/edit")

      fill_in "Name", with: "I am a channel name over 40 characters long"
      fill_in "Position", with: 2
      click_button "Submit"

      expect(page).to have_text("Name is too long")
    end

    it "allows for channels to be deleted" do
      channel = FactoryBot.create(:channel, name: "Employees")

      sign_in admin

      visit root_path
      click_link "Forums"
      expect(page).to have_text(/Employees/i)

      within(".channel") do
        accept_confirm do
          find("[data-method='delete']").click()
        end
      end

      expect(page).to_not have_text(/Employees/i)
      expect(page).to_not have_link(href: "/channels/employees")
    end
  end
end
