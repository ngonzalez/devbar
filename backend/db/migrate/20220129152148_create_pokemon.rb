class CreatePokemon < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemon do |t|
      t.string :item_id, null: false, unique: true
      t.string :name, null: false, unique: true
      t.string :type_1, null: false
      t.string :type_2
      t.integer :total, null: false
      t.integer :hp, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :sp_atk, null: false
      t.integer :sp_def, null: false
      t.integer :speed, null: false
      t.integer :generation, null: false
      t.boolean :legendary, null: false
      t.datetime :deleted_at
      t.index [:name]
      t.index [:type_1]
      t.index [:type_2]
      t.timestamps
    end
  end
end
