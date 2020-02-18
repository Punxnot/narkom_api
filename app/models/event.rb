class Event < ApplicationRecord
  belongs_to :age

  validates_uniqueness_of :description, scope: :age_id
end
