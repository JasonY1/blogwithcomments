require 'spec_helper'

describe User do                    #Describe user class app/models/user.rb
  
  before do                         #before test use data of new user
    @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foofoo", password_confirmation: "foofoo")
  end
  
  subject { @user }                 #sets user as subject
  
  it { should respond_to(:name) }   #verifies presence of name and email
  it { should respond_to(:email) }  #password
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
                                    #
  it { should be_valid }            #
    
  describe "when name is not present" do   #test name presence
    before { @user.name = " " }            #before do name is nil
    it { should_not be_valid }             #nil is not valid for name
  end
  
  describe "when email is not present" do  #test email presence
    before { @user.email = " " }           #before do email is nil 
    it { should_not be_valid }             #should not be valid 
  end
  
  describe "when name is too long" do     #testing length
    before { @user.name = "a" * 51 }      #before user name is a*51
    it { should_not be_valid }            #should not be valid
  end
  
  describe "when email format is invalid" do  #testing invalid email
    it "should be invalid" do                 #invalid address examples
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|     #for each invalid address
        @user.email = invalid_address         #when user email is invalid
        expect(@user).not_to be_valid         #it is not valid
      end
    end
  end
  
  describe "when email format is valid" do    #testing valid email
    it "should be valid" do                   #valid email examples
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|       #for each valid address
        @user.email = valid_address           #when user email is valid
        expect(@user).to be_valid             #it is valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup  #duplicate user(clone for singleton classes)
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save         #Save the same email
    end
    
    it { should_not be_valid }          #should not work
  end
  
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com",
                        password: " ", password_confirmation: " ")
    end
    it { should_not be_valid }     #when password is nil not valid
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }    #when password mismatch not valid
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }  #with password aaaaa should not work because 2short
  end
  
  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }  #set found user by finding by email params
    
    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }    #it should authenticate found user password 
    end
    
    describe "with invalid password" do
      let (:user_for_invalid_password) { found_user.authenticate("invalid") }
      
      it { should_not eq user_for_invalid_password }      #invalid password should be invalid
      specify { expect(user_for_invalid_password).to be_false }
    end
  end
end
