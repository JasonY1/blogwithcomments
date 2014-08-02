class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])    #Show current user by finding current user data
  end
  
  def new
    @user = User.new                  #new User for current instance
  end
  
  def create
    @user = User.new(user_params)     #Create new user per params
    if @user.save                     #if valid information provided save
      sign_in @user                   #user signs in after creation of account
      flash[:success] = "Welcome to the Sample App!" #flash msg if success
      redirect_to @user               # redirect to @user page
    else
      render 'new'                    #else render new
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
