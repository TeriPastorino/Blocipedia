require 'rails_helper'

describe "User registration" do 

  describe "without validation errors" do
    it "should have content 'Sign Up'" do
      visit signup_path
      expect(page).to have_content('Sign up')
    end

    it "does not allow empty fields" do
      visit signup_path
      click_button 'Signup'
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Email can't be blank")
    end


  end
  
end