class Fatura < ApplicationRecord
  belongs_to :cartao
  has_many :lancamentos, dependent: :destroy

  validates :mes, :ano, presence: true

  def competencia
    Competencia.find_by!(mes: mes, ano: ano)
  end

  def total
    lancamentos.sum(:valor)
  end
end
