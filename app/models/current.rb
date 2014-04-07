class Current < ActiveRecord::Base
  belongs_to :project
  belongs_to :item
  validates :item_id, presence: :true
  validates :quantity, presence: :true
  validates_numericality_of :quantity, greater_than: 0
  validates :pass, presence: :true
  validates :delivery, presence: :true
end
