class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save!
      @user.send_activation_email
      render json: { message: 'User Saved!' }, status: 200
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password_digest )
  end
end
