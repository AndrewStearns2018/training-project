class Project < ApplicationRecord
  include PhotoUploader::Attachment(:image)

  belongs_to :category

  validates :name, presence: true
  validates :goal, presence: true, numericality: { only_integer: true }
end
