class User < ApplicationRecord
  attr_accessor :activation_token
  before_create :create_activation_digest
  validates :firstname, presence: true, length: { minimum: 3 }
  validates :lastname, presence: true, length: { minimum: 2 }
  validates :email, uniqueness: { case_sensitive: false }, presence: true, length: { maximum: 100 }
  validates :password, confirmation: true, presence: true, length: { minimum: 7 }
  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
   end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  private def email_downcase
    self.email = email_downcase
  end
end
