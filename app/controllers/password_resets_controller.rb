class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url notice: "Email sent with password reset instructions"
  end

  def edit
    @user = User.find_by_password_reset_token!(param[:id])
  end

  def udate
    @user = User.find_by_password_reset_token!(param[:id])
    if @user.password_reset_sent_at < 3.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired"
    elsif @user.update_attributes(password_reset_params)
      redirect_to root_url
    else
      render :edit
    end
  end

  private
    def password_reset_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
