class CreateLancamentos < ActiveRecord::Migration[8.0]
  def change
    create_table :lancamentos do |t|
      t.date :data
      t.integer :natureza
      t.decimal :valor, precision: 15, scale: 2
      t.integer :frequencia
      t.integer :quantidade
      t.references :fatura, foreign_key: true
      t.references :competencia, null: false, foreign_key: true

      t.timestamps
    end
  end
end
