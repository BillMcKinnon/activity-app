class Activity < ApplicationRecord
  belongs_to :user
  before_save { name.downcase! }

  validates :name, :category, :minutes, presence: true
  validates :name, length: { maximum: 50 }
  validates :minutes, numericality: true
end

