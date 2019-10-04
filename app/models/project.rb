require 'aasm'
class Project < ApplicationRecord
  include PhotoUploader::Attachment(:landscape_image)
  include PhotoUploader::Attachment(:thumbnail_image)
  include AASM

  belongs_to :category
  has_many :rewards, dependent: :destroy
  has_many :contributions, dependent: :destroy

  validates :name, presence: true
  validates :goal, presence: true, numericality: { only_integer: true }

  scope :draft, -> { where(aasm_state: 'draft') }
  scope :upcoming, -> { where(aasm_state: 'upcoming') }
  scope :ongoing, -> { where(aasm_state: 'ongoing') }
  scope :success, -> { where(aasm_state: 'success') }
  scope :failure, -> { where(aasm_state: 'failure') }
  scope :user_accessible, -> { where(aasm_state: ['upcoming', 'ongoing', 'success']) }

  aasm do
    state :draft, initial: true
    state :upcoming, :ongoing, :success, :failure

    event :fields_complete do
      transitions from: :draft, to: :upcoming, guard: :are_fields_complete?
    end

    event :has_reward do
      transitions from: :upcoming, to: :ongoing, guard: :reward_exist?
    end

    event :trigger_success do
      transitions from: :ongoing, to: :success, guard: :project_successful?
    end

    event :trigger_failure do
      transitions from: :ongoing, to: :failure, guard: :project_failed?
    end
  end

  def are_fields_complete?
    !short_description.nil? && !long_description.nil? && !thumbnail_image.nil? && !landscape_image.nil?
  end

  def reward_exist?
    !rewards.empty?
  end

  def project_successful?
    contributions.sum(:amount) >= goal
  end

  def project_failed?
    contributions.sum(:amount) <= goal
  end
end
