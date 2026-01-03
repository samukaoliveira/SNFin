class Cartao < ApplicationRecord
  has_many :faturas, dependent: :destroy

  validates :nome, presence: true
  validates :limite, numericality: { greater_than: 0 }

  after_create :gerar_faturas_existentes

  private

  def gerar_faturas_existentes
    Competencia.find_each do |comp|
      Fatura.find_or_create_by!(
        cartao: self,
        mes: comp.mes,
        ano: comp.ano
      )
    end
  end
end
