FactoryBot.define do
  factory :user, class: User do
    uuid { Faker::Internet.uuid } 
    name { Faker::Name.name } 
    username { Faker::Internet.username( separators: %w(_)) }
    email { Faker::Internet.email(separators: '') } 
    password { Faker::Internet.password }
  end
end