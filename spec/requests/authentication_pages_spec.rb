require 'spec_helper'

describe "Authentication" do

  subject { page }        # subject for page

  describe "signin page" do       #signup page is test subject
    before { visit signin_path }  #before test make sure on right page

    it { should have_content('Sign in') } #content and title "Sign in"
    it { should have_title('Sign in') }
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do      #condition invalid information
      before { click_button "Sign in" }
      
      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') } #test if div class alert aand alert-error
      
      describe "after visiting another page" do       #render does no count as a request in a re-render
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do        #condition valid information
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email.upcase   #use email upcased
        fill_in "Password", with: user.password       #use password
        click_button "Sign in"                        #sign in with information provided above
      end
      
      it { should have_title(user.name) }   #page should have user name as title
      it { should have_link('Profile',      href: user_path(user)) }    #Link to profile
      it { should have_link('Sign out',     href: signout_path) }       #link to sign out should be provided        
      it { should_not have_link('Sign in',  href: signin_path) }        #link to sign in should not exist while signed in
      
      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end
end