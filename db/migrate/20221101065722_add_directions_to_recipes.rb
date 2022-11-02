class AddDirectionsToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :directions, :text, array: true
  end
end
