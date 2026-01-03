class AddCicloToCartaos < ActiveRecord::Migration[8.0]
  def change
    add_column :cartaos, :fechamento, :integer
    add_column :cartaos, :vencimento, :integer
  end
end
