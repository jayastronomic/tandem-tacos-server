FactoryBot.define do
  factory :recipe, class: :recipe do
    ingredients = []
    10.times { ingredients << Faker::Food.ingredient }

    uuid { Faker::Internet.uuid } 
    name { Faker::Food.dish }
    description { Faker::Food.description }
    ingredients {ingredients }
    tags { [Faker::Lorem.characters(number: 5), Faker::Lorem.characters(number: 10)] }
  end
end