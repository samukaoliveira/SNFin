class LancamentoService
  def initialize(lancamento)
    @lancamento = lancamento
  end

  def call
    return unless lancamento.frequencia == "fixo"

    Lancamento.transaction do
      gerar_copias_ate_dezembro
    end
  end

  private

  attr_reader :lancamento

  def gerar_copias_ate_dezembro
    data_atual = lancamento.data.next_month
    fim_do_ano = Date.new(lancamento.data.year, 12, 31)

    while data_atual <= fim_do_ano
      criar_lancamento(data_atual)
      data_atual = data_atual.next_month
    end
  end

  def criar_lancamento(data)
    # Evita duplicação no mesmo mês com a mesma descrição
    Lancamento.find_or_create_by!(
      descricao: lancamento.descricao,
      data: data
    ) do |l|
      l.valor      = lancamento.valor
      l.natureza   = lancamento.natureza
      l.frequencia = "fixo"
    end
  end
end
