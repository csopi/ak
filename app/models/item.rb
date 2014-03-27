class Item < ActiveRecord::Base
  belongs_to :unit
  has_many :plans
  has_many :projects, through: :plans
  validates :name, presence: true, uniqueness: true
  validates :unit_id, presence: true
  default_scope { order(:name) }
end
