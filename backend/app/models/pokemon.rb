class Pokemon < ApplicationRecord
  self.table_name = :pokemon

  acts_as_paranoid

  validates :name, presence: true, uniqueness: true
end
