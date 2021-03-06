module SessionsHelper
  
  def sign_in(user)                               #define signin for user
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token #permanent = 20 years
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)  # same as self.current_user = ...
    @current_user = user   
  end
  
  def current_user
    remember_token = User.digest(cookies[:remember_token] )
    @current_user ||= User.find_by(remember_token: remember_token)  #either current user or find by token
  end
  
  def sign_out
    current_user.update_attribute(:remember_token,
                                  User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
