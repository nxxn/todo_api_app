FactoryBot.define do
  factory :task do
    title { Faker::Lorem.word }
    done { false }
  end

  factory :tag do
    title { Faker::Lorem.word }
  end

  factory :tagging do
    task
    tag
  end
end
