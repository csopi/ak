class Project < ActiveRecord::Base
  belongs_to :user
  has_many :plans
  has_many :items, through: :plans

  has_many :currents
  has_many :items, through: :currents
  validates :name, presence: true, uniqueness: true
  validates :user_id, presence: true
end
