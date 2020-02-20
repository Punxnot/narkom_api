class Age < ApplicationRecord
  has_many :events, dependent: :destroy
  validates :days, presence: true, uniqueness: true
end
