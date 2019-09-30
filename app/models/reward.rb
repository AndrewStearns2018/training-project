class Reward < ApplicationRecord
  belongs_to :project
  has_many :contributions

  validates :name, presence: true
  validates :units, presence: true, numericality: { only_integer: true }
end
