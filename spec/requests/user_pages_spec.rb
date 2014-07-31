require 'spec_helper'

describe "User pages" do
  
  subject { page }
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }    #Use Factorygirl for users
    before { visit user_path(user) }            # be on user_path for user
    
    it { should have_content(user.name) }       # content has user's name
    it { should have_title(user.name) }         # title has user's name
  end
  
  describe "signup page" do                     # page test for signup page
    before { visit signup_path }                # before signup
    
    it { should have_content('Sign up') }       #should have Sign up as title and content
    it { should have_title(full_title('Sign up')) }
  end
  
  describe "signup" do                          #test sign up action
    
    before { visit signup_path }
    
    let(:submit) { "Create my account" }        # when submit, create account
    
    describe "with invalid information" do      # Test what happens in an invalid information scenario
      it "should not create a user" do          # expected result should not create user
        expect { click_button submit }.not_to change(User, :count)
      end                                       # should not change the total user count
    end
    
    describe "with valid information" do                    #Test what happens when valid information is used
      before do
        fill_in "Name",         with: "Example User"        #use sample "Valid" information
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foofoo"
        fill_in "Confirmation", with: "foofoo"
      end
      
      it "should create a user" do                          # with valid information it should increase total user count
        expect { click_button submit }.to change(User, :count).by(1)
      end                                                   # by one for the creation of account
    end
  end
end
