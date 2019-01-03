class UserMailer < ApplicationMailer
  def account_activation(user, origin)
    @user = user
    @origin = origin
    mail(to: user.email, Subject: 'TaskApp: Account Activation')
  end
end
