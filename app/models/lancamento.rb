class Lancamento < ApplicationRecord
  belongs_to :fatura, optional: true
  belongs_to :competencia

  enum :natureza, { receita: 0, despesa: 1 }
  enum :frequencia, { unico: 0, fixo: 1, repetido: 2 }

  validates :descricao, :data, :natureza, :valor, :frequencia, presence: true
  validates :valor, numericality: { greater_than: 0 }

  validates :quantidade,
            presence: true,
            numericality: { greater_than: 1 },
            if: :repetido?

  before_validation :atribuir_competencia

  private

  def atribuir_competencia
    return if data.blank?

    self.competencia = Competencia.por_data(data)
  end
end
