class Project < ActiveRecord::Base
  belongs_to :user
  has_many :plans, dependent: :destroy
  has_many :items, through: :plans

  has_many :currents, dependent: :destroy
  has_many :items, through: :currents
  validates :name, presence: true, uniqueness: true
  validates :user_id, presence: true
end
