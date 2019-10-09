class Contribution < ApplicationRecord
  include AASM
  belongs_to :user
  belongs_to :project
  belongs_to :reward, optional: true

  validates :amount, presence: true, numericality: { only_integer: false }

  scope :pending, -> { where(aasm_state: 'pending') }
  scope :success, -> { where(aasm_state: 'success') }

  aasm do
    state :pending, initial: true
    state :success

    event :payment_accepted do
      transitions from: :pending, to: :success, guard: :payment_successful?
    end
  end

  def payment_successful?
    MangoPay::PayIn.fetch(pay_in_id)["Status"] == "SUCCEEDED"
  end
end
