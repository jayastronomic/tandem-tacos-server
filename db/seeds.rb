require 'httparty'

Recipe.destroy_all

response = HTTParty.get("https://guac-is-extra.herokuapp.com")
recipes = response.parsed_response



recipes.each do |recipe|
  r = ["halal", "kosher", "vegan", "vegetarian", "nut-free", "dairy-free", "gluten-free"]
  Recipe.create(name: recipe["name"], directions: recipe["directions"], restrictions: [ r.sample, r.sample, r.sample ].uniq ) do |instance|
    instance.ingredients.build(recipe["ingredients"])
  end
end


