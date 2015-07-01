class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    # If there is a user
      # set the user's confirm token to nil
      # set the user.email_confirmed to true
      # redirect to the root url with a flash notice
    # else
      # set flash error
      # redirect to the root url
  end


  def show
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver 
      flash[:notice] = "Please confirm your email address to continue"
      redirect_to root_url
    else
      flash[:error] = 'An error has occured'
      render :new
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
