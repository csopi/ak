class Item < ActiveRecord::Base
  belongs_to :unit
  validates :name, presence: true, uniqueness: true
  validates :unit_id, presence: true
  default_scope { order(:name) }
end
