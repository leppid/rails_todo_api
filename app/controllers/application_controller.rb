class ApplicationController < ActionController::API
  def current_user
    User.find_by(activation_digest: request.headers['Authorization'])
  end
end
