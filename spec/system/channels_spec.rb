require 'rails_helper'

RSpec.describe "Channels", type: :system do
  context "as a guest" do
    it "doesn't allow for channels to be created" do
      visit '/forums'
      expect(page).to_not have_link("Create Channel", href: new_channel_path)

      visit new_channel_path
      expect(page).to have_text("Login")
      expect(page).to have_field("Email")
    end
  end
end
