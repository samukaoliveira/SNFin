class AddPagoInLancamentos < ActiveRecord::Migration[8.0]
  def change
    add_column :lancamentos, :pago, :boolean
  end
end
