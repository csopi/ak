class Item < ActiveRecord::Base
  belongs_to :unit
  has_many :plans
  has_many :projects, through: :plans

  has_many :currents
  has_many :projects, through: :currents
  validates :name, presence: true, uniqueness: true
  validates :unit_id, presence: true
  default_scope { order(:name) }
end
