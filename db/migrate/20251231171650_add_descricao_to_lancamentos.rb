class AddDescricaoToLancamentos < ActiveRecord::Migration[8.0]
  def change
    add_column :lancamentos, :descricao, :string
  end
end
