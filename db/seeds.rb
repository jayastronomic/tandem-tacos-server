require 'httparty'

Recipe.destroy_all
User.destroy_all

response = HTTParty.get("https://guac-is-extra.herokuapp.com")
recipes = response.parsed_response

def bubble_sort(array)
  swap = true
  while swap
    swap = false
    (array.length - 1).times do |i|
      if array[i]["name"] > array[i + 1]["name"]
        swap = true
        array[i], array[i + 1] = array[i + 1], array[i]
      end
    end 
  end
end

bubble_sort(recipes)
images = Dir.glob('./app/assets/tandem/*').select { |e| File.file? e }

recipes.each_with_index do |recipe, index|
  r = ["halal", "kosher", "vegan", "vegetarian", "nut-free", "dairy-free", "gluten-free"]
  # create an array of sentences that end with a period
  directions = recipe["directions"].join.split(".").map {|s| s.concat(".")}
   recipe = Recipe.create(name: recipe["name"], directions: directions, restrictions: [ r.sample, r.sample, r.sample ].uniq ) do |instance|
    instance.image.attach(io: File.open(images[index]), filename: File.basename(images[index]), content_type: File.extname(images[index]))
    instance.ingredients.build(recipe["ingredients"])
  end
end


