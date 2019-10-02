class Reward < ApplicationRecord
  belongs_to :project
  has_many :contributions, dependent: :destroy

  validates :name, presence: true
  validates :units, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: false }
  validate :project_not_ongoing?

  private

  def project_not_ongoing?
    project_state = self.project.aasm.current_state
    project_state == :draft || project_state == :upcoming
  end
end
