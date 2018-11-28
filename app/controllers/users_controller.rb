class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.save!
      origin = request.headers['origin']
      UserMailer.account_activation(@user, origin).deliver
      render json: { message: 'User Saved!' }, status: 200
    end
  end

  def confirmemail
    user = User.find_by_activation_digest(params[:user])
    if user && user.update_column(:activated, true)
      render json: { message: 'Email Confirmed!' }, status: 200
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation )
  end
end
