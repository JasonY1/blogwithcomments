class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])    #def show for show.html.erb
  end
  
  def new
  end
end
