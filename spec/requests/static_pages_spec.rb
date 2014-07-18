require 'spec_helper'

describe "Static pages" do
  # Indicate Home page as subject
  
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')    #verify 'Sample App' is there. 
    end
    
    it "should have the title 'Home'" do            #verify base_title
      visit '/static_pages/home'  
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end
    
    it "should not have a custom page title" do     #verify | Home is not on home page
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end
  
  
  describe "Help page" do                           #verify help pages has content Help
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have title 'Help'" do                #verify Help page has title indicated below
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
  end
  
  describe "About page" do                          #verify about page has About Us on page
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Us')
    end
    
    it "should have the title 'About Us'" do        #verify about page has correct title
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end
  end
end
