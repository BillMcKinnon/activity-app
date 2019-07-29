class Activity < ApplicationRecord
  belongs_to :user
  before_save { name.downcase! }

  validates :name, :category, :minutes, presence: true
  validates :name, length: { maximum: 50 }
  validates :category, inclusion: { in: %w(contributor subtractor),
                                    message: "Must be contributor or subtractor." } 
  validates :minutes, numericality: { only_integer: true, less_than_or_equal_to: 525600, greater_than: 0 }
end

