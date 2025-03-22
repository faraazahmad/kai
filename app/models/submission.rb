class Submission < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true
end
