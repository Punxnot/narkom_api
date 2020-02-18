class Age < ApplicationRecord
  has_many :events
  validates :days, presence: true, uniqueness: true
end
