require 'rails_helper'

describe "User registration" do 
  describe "without validation errors" do
    it "should have content 'Sign Up'" do
      visit new_user_registration_path
      expect(page).to have_content('Sign up')
    end
  end
  
end