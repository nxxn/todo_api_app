require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should have_many(:tasks).through(:taggings) }

   it { should validate_presence_of(:title) }
end
