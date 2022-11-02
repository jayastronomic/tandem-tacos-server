class ChangeTagsToRestrictionsFromRecipes < ActiveRecord::Migration[7.0]
def change
  remove_column :recipes, :tags, :string
  add_column :recipes, :restrictions, :string, array: true
end
end
