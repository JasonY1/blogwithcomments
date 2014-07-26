class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }      #validates :name field and verifies it is true
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i     #simple email regex for most common emails.
  validates :email, presence: true, 
                    format:     { with: VALID_EMAIL_REGEX },  #validates email validity using regex
                    uniqueness: { case_sensative: false }       #uniquness but not case sensative
  
  has_secure_password
  validates :password, length: { minimum: 6 }                   #password minimum length

end
