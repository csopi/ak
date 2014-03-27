class Unit < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :items
end
