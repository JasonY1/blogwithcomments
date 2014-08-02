require 'spec_helper'

describe "Static pages" do
  # Indicate Home page as subject
  
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_content('Sample App') }    #verify 'Sample App' is there. 
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }      #verify | Home is not on home page
  end
  
  describe "Help page" do   
    before { visit help_path }                  #verify help pages has content Help
    
    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }   #verify Help page has title indicated below
  end
  
  describe "About page" do                          #verify about page has About Us on page
    before { visit about_path }
    
    it { should have_content('About Us') }
    it { should have_title(full_title('About Us')) }  #verify about page has correct title
  end
  
  describe "Contact page" do
    before { visit contact_path }
    
    it { should have_content('Contact') }           #verify page content and title have Contact
    it { should have_title(full_title('Contact')) }
  end
end
