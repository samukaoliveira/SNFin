class Lancamento < ApplicationRecord
  belongs_to :fatura, optional: true
  belongs_to :competencia
  before_validation :atribuir_fatura_cartao

  enum :natureza, { receita: 0, despesa: 1 }
  enum :frequencia, { unico: 0, fixo: 1, repetido: 2 }

  validates :descricao, :data, :natureza, :valor, :frequencia, presence: true
  validates :valor, numericality: { greater_than_or_equal_to: 0 }

  validates :quantidade,
            presence: true,
            numericality: { greater_than: 1 },
            if: :repetido?

  # Evita lançamentos duplicados
  validates :descricao, uniqueness: { scope: [ :data, :valor, :natureza ],
    message: "já existe um lançamento com a mesma descrição, data, valor e natureza" }

  before_validation :atribuir_competencia
  after_create :gerar_lancamentos_fixos

  private

  def atribuir_competencia
    return if data.blank?

    self.competencia = Competencia.por_data(data)
  end

  def gerar_lancamentos_fixos
    LancamentoService.new(self).call
  end

  def atribuir_fatura_cartao
    return if data.blank?

    cartao = fatura&.cartao
    return unless cartao

    fechamento = cartao.fechamento
    data_lancamento = data.to_date

    data_fatura =
      if data_lancamento.day > fechamento
        data_lancamento.next_month.beginning_of_month
      else
        data_lancamento.beginning_of_month
      end

    self.fatura = cartao.faturas.find_or_create_by!(
      mes: data_fatura.month,
      ano: data_fatura.year
      )
  end
end
