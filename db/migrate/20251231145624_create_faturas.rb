class CreateFaturas < ActiveRecord::Migration[8.0]
  def change
    create_table :faturas do |t|
      t.references :cartao, null: false, foreign_key: true
      t.integer :mes
      t.integer :ano

      t.timestamps
    end
  end
end
