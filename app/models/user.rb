class User < ApplicationRecord
  has_many :tasks

  accepts_nested_attributes_for :tasks

  attr_accessor :activation_token
  before_create :create_activation_digest
  validates :firstname, presence: true, length: { minimum: 3 }
  validates :lastname, presence: true, length: { minimum: 2 }
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  validates :email, uniqueness: { case_sensitive: false }, presence: true, length: { maximum: 20 }, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 7 }, on: :create
  validates :password_confirmation, presence: true, length: { minimum: 7 }, on: :create
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

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
end
