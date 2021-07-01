require 'rails_helper'

RSpec.describe "Users", type: :system do
  context "as a guest" do
    it "allows for user creation" do
      visit root_path
      
      expect(page).to have_link("Register", href: '/register')
      click_link("Register")
  
      expect(page).to have_field("Email")
      expect(page).to have_field("Username")
      expect(page).to have_field("Password")
      expect(page).to have_field("Password confirmation")
  
      fill_in "Email", with: "test@example.com"
      fill_in "Username", with: "Newbie"
      fill_in "Password", with: "secure123"
      fill_in "Password confirmation", with: "secure123"
      click_button "Submit"
  
      expect(page).to have_current_path("/")
      expect(page).to have_text("Newbie")
      expect(page).to_not have_text("Register")
    end

    it "allows for login" do
      user = FactoryBot.create(:user, email: "test@example.com", username: "Newbie", password: "secure123")

      visit root_path
      
      expect(page).to have_link("Login", href: '/login')
      click_link("Login")
  
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
  
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "secure123"
      click_button "Submit"
  
      expect(page).to have_current_path("/")
      expect(page).to have_text("Signed in successfully.")
      expect(page).to have_text("Newbie")
      expect(page).to_not have_text("Login")
    end
  end

  context "as a logged in user" do
    let(:user) { FactoryBot.create(:user, email: "test@example.com", username: "Newbie", password: "secure123") }
    it "allows for logout" do
      sign_in user
      
      visit root_path
      expect(page).to have_link("Logout", href: '/logout')
      
      click_link("Logout")
      expect(page).to have_current_path("/")
      expect(page).to have_text("Signed out successfully.")
      expect(page).to_not have_text("Logout")
    end

    it "allows for updating of email, username, and biography" do
      sign_in user

      visit root_path
      click_link("Newbie")
      expect(page).to have_link("Edit Profile")

      click_link("Edit Profile")
      expect(page).to have_field("Email", with: "test@example.com")
      expect(page).to have_field("Username", with: "Newbie")
      expect(page).to have_css("#cke_user_biography")

      fill_in "Email", with: "testing@example.com"
      fill_in "Username", with: "Pro"

      click_button("Submit", match: :first)
      
      expect(page).to have_current_path("/users/pro")
      expect(page).to have_text("Pro")

      click_link("Edit Profile")
      expect(page).to have_field("Email", with: "testing@example.com")
      expect(page).to have_field("Username", with: "Pro")
    end

    it "allows for password updating" do
      sign_in user

      visit root_path
      click_link("Newbie")
      click_link("Edit Profile")
      
      expect(page).to have_field("Password", with: "")
      expect(page).to have_field("Password confirmation", with: "")
      expect(page).to have_field("Current password", with: "")

      fill_in "Password", with: "megasecure123"
      fill_in "Password confirmation", with: "megasecure123"
      fill_in "Current password", with: "secure123"

      page.all(".form__submit")[1].click()
      expect(page).to have_text("Your account has been updated successfully.")

      click_link("Logout")
      click_link("Login")


      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "megasecure123"
      click_button "Submit"
  
      expect(page).to have_current_path("/")
      expect(page).to have_text("Signed in successfully.")
    end

    it "requires current password when updating password" do
      sign_in user

      visit root_path
      click_link("Newbie")
      click_link("Edit Profile")
      
      fill_in "Password", with: "megasecure123"
      fill_in "Password confirmation", with: "megasecure123"

      page.all(".form__submit")[1].click()
      expect(page).to have_text("Current password can't be blank")
    end
  end

end
