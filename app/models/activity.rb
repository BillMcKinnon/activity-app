class Activity < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :entries
  before_save { name.downcase! }

  validates :name, :category, presence: true
  validates :name, length: { maximum: 50 }
  validates :category, inclusion: { in: %w(contributor subtractor),
                                    message: "Must be contributor or subtractor." } 
end

