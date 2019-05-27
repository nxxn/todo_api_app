class Tag < ApplicationRecord
  has_many :taggings, dependent:  :destroy
  has_many :tasks, -> { distinct }, through: :taggings

  validates_presence_of :title

  validates_uniqueness_of :title
end
