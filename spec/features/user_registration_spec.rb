require 'rails_helper'

describe "User registration" do 

  it "should have content 'Sign Up'" do
    visit signup_path
    expect(page).to have_content('Sign up')
  end

  describe "with validation errors" do
    it "does not allow empty fields" do
      visit signup_path
      click_button 'Signup'
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Email can't be blank")
    end
  end

  describe "without validation errors" do
    # when I click the button, where do I redirect to?
    it "redirects to (where?)"
    # I expet that when i click the button it increases the User.count
    it "saves the users"
  end
  
end