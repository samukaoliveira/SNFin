class CreateCompetencia < ActiveRecord::Migration[8.0]
  def change
    create_table :competencia do |t|
      t.integer :mes
      t.integer :ano

      t.timestamps
    end
  end
end
