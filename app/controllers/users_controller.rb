class UsersController < ApplicationController


  def create
    @user = User.new(user_params)
    if @user.password === @user.password_confirmation
      email_exists = User.find_by(email: @user.email)
      if !email_exists
        if @user.save!
          origin = request.headers['origin']
          UserMailer.account_activation(@user, origin).deliver
          render json: { message: 'Almost done! Please check your email for activate your account.', status: 'success' }, status: 200
        else
          render json: { message: User.create(user_params).errors, status: 'error'}, status: 404 
        end
      else
        render json: { message: 'Email Exists!', status: 'error' }, status: 207 
      end
    else
      render json: { message: 'Passwords do not match', status: 'error' }, status: 207
    end
  end


  def confirmemail
    user = User.find_by_activation_digest(params[:user])
    if user && user.update_column(:activated, true)
      render json: { message: 'Account successfully activated', status: 'success' }, status: 200
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation )
  end
end
