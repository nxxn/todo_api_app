require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should have_many(:tags).through(:taggings) }

  it { should validate_presence_of(:title) }
end
