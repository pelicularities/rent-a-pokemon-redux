class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.text :description
      t.string :location
      t.numeric :price
      t.references :user, null: false, foreign_key: true
      t.references :pokedex, null: false, foreign_key: true

      t.timestamps
    end
  end
end
