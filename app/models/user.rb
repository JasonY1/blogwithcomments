class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_create :create_remember_token     #call back method to create token
  
  validates :name, presence: true, length: { maximum: 50 }      #validates :name field and verifies it is true
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i     #simple email regex for most common emails.
  validates :email, presence: true, 
                    format:     { with: VALID_EMAIL_REGEX },  #validates email validity using regex
                    uniqueness: { case_sensative: false }       #uniquness but not case sensative
  
  has_secure_password
  validates :password, length: { minimum: 6 }                   #password minimum length

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)    #hash for passwords uncrackable
  end
  
  private
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)  #protect token
    end
end
