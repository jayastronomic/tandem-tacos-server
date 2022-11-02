class CreateIngredients < ActiveRecord::Migration[7.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :quantity, null: false
      t.string :preparation
      t.uuid :uuid, type: :uuid, default: -> { "gen_random_uuid()" }, null: false
      t.references :recipe, null: true
  
      t.timestamps
    end
  end
end
