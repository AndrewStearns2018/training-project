class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :reward

  validates :amount, presence: true, numericality: { only_integer: false }
end
