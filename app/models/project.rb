class Project < ApplicationRecord
  include PhotoUploader::Attachment(:landscape_image)
  include PhotoUploader::Attachment(:thumbnail_image)

  belongs_to :category
  has_many :rewards, dependent: :destroy
  has_many :contributions, dependent: :destroy

  validates :name, presence: true
  validates :goal, presence: true, numericality: { only_integer: true }
end
