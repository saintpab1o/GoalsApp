FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password {'password'}
  end
end


#how did we create this file? what command or gem? 