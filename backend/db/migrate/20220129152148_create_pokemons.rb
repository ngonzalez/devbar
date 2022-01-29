class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :type_1, null: false
      t.string :type_2, null: false
      t.integer :total, null: false
      t.integer :hp, null: false
      t.integer :attack, null: false
      t.integer :defense, null: false
      t.integer :sp_atk, null: false
      t.integer :sp_def, null: false
      t.integer :speed, null: false
      t.integer :generation, null: false
      t.boolean :legendary, null: false
      t.timestamps
    end
  end
end
