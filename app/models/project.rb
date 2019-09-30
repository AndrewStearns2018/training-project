class Project < ApplicationRecord
  include PhotoUploader::Attachment(:landscape_image)
  include PhotoUploader::Attachment(:thumbnail_image)

  belongs_to :category

  validates :name, presence: true
  validates :goal, presence: true, numericality: { only_integer: true }
end
