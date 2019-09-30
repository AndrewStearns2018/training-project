class Reward < ApplicationRecord
  belongs_to :project
  has_many :contributions, dependent: :destroy

  validates :name, presence: true
  validates :units, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: false }
end
