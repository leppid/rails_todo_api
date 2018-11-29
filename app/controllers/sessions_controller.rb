class SessionsController < ApplicationController

  def create

    user = User.find_by(email: params[:session][:email].downcase)
     if user
      if user.authenticate(params[:session][:password])
       if user.activated
        render json: { user: user }, status: 200
       else
          render json: { message: 'Account not activated. Check yor email for the activation link' }, status: 207
       end
      else
        render json: { message: 'Invalid Email or Password' }, status: 207
      end
    else
      render json: { message: 'User doesnt exist' }, status: 207
    end

  end

private

def session_params
  params.require(:session).permit(:email, :password)
end

end
