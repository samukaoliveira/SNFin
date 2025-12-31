class CreateCartaos < ActiveRecord::Migration[8.0]
  def change
    create_table :cartaos do |t|
      t.string :nome
      t.decimal :limite

      t.timestamps
    end
  end
end
