class SessionsController < ApplicationController

  def new
    if current_user
      render json: { message: 'You already log in!' }, status: 200
    else
      render json: { errors: 'You are not!' }, status: 400
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        login user
        redirect_to tasks_path
        msg = 'Welcome ' + user.firstname + ' ' + user.lastname + '!'
        flash[:success] = msg
      else
        msg = 'Account not activated. Check yor email for the activation link'
        flash[:warning] = msg
        redirect_to login_path
    end
    else
      flash[:danger] = 'Invalid Email or Password'
      render 'new'
     end
end

end
