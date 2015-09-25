class UsersController < ApplicationController
  
  def new
    @user = User.new
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
  
  def confirm_email
    user = User.find_by(confirm_token: params[:id])
    if user
      # set the user's confirm token to nil
      user.email_activate      
      flash[:success] = "Welcome to Blocipedia your email has been confirmed. Sign in to continue"
      redirect_to root_url    
    else
      flash[:error] = "Sorry, User does not exist!"
      redirect_to root_url
    end
  end


  def show
    @user = current_user
  end



  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
