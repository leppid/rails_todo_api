class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail(to: user.email, Subject: 'TaskApp: Account Activation')
  end

end
