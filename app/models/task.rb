class Task < ApplicationRecord

  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true
  validates :priority, presence: true,
    numericality: {
      only_integer: true,
      less_than_or_equal_to: 3,
      more_than_or_equal_to: 1
    }
  validates :duedate, presence: true


end
