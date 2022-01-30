class Pokemon < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true, uniqueness: true
end
