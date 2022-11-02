class RemoveDescriptionFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :description, :string
    remove_column :recipes, :ingredients, :string, array: true
    remove_column :recipes, :instructions, :string
  end
end
