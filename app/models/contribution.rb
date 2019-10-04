class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :reward, optional: true

  validates :amount, presence: true, numericality: { only_integer: false }
end
