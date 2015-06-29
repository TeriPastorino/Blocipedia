class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver flash[:notice] = "Please confirm your email address to continue"
      redirect_to root_url
    else
      flash[:error] = 'An error has occured'
      render :new
    end

    # def confirm_email
    #   user = User.find_by
    # end


    def show
      @user = current_user
    end

  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
