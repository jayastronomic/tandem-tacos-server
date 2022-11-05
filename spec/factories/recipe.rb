FactoryBot.define do
  factory :recipe, class: :recipe do
    uuid { Faker::Internet.uuid } 
    name { Faker::Food.dish }
    directions { [Faker::Food.description, Faker::Food.description] }
  end
end