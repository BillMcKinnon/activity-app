class Activity < ApplicationRecord
  belongs_to :user
  has_many :entries, dependent: :destroy
  before_save { name.downcase! }

  validates :name, :category, presence: true
  validates :name, length: { maximum: 50 }
  validates_uniqueness_of :name, scope: :user_id
  validates :category, inclusion: { in: %w(contributor subtractor),
                                    message: "Must be contributor or subtractor." } 
end

