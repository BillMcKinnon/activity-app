class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :activity, dependent: :destroy

  validates :minutes, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 525600, greater_than: 0 }
end
