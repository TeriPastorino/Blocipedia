class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "You have successfully signed up"
    else
      render "new"
    end

    def show
      @user = current_user
    end
    
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
