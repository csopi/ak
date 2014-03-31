class Plan < ActiveRecord::Base
  belongs_to :project
  belongs_to :item
  validates :item_id, presence: :true
  validates :quantity, presence: :true, numericality: true
end
