class Plan < ActiveRecord::Base
  belongs_to :project
  belongs_to :item
  validates :item_id, presence: :true
  validates :quantity, presence: :true
  validates_numericality_of :quantity, greater_than: 0
end
