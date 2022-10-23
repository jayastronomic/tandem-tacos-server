class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.references :user, null: true
      t.string :tags, array: true
      t.string :ingredients, array: true
      t.uuid :uuid, type: :uuid, default: -> { "gen_random_uuid()" }, null: false
      t.timestamps
    end
    add_index :recipes, :name
  end
end
