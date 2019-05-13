class Task < ApplicationRecord
  has_many :taggings, dependent:  :destroy
  has_many :tags, -> { distinct }, through: :taggings

  validates_presence_of :title

  def tag_list(tag_names)
    tag_names.each do |t|
      self.tags << Tag.where(title: t).first_or_create! unless self.tags.exists?(title: t)
    end
  end
end
