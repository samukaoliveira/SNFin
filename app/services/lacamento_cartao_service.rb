class Cartoes::LancamentoCartaoService
  def initialize(cartao:, descricao:, data:, valor:, natureza:, frequencia:)
    @cartao = cartao
    @descricao = descricao
    @data = data
    @valor = valor
    @natureza = natureza
    @frequencia = frequencia
  end

  def call
    fatura = Fatura.find_or_create_by!(
      cartao: @cartao,
      mes: @data.month,
      ano: @data.year
    )

    Lancamento.create!(
      descricao: @descricao,
      data: @data,
      valor: @valor,
      natureza: @natureza,
      frequencia: @frequencia,
      fatura: fatura
    )
  end
end
