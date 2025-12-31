# db/seeds.rb

require 'date'

# Limpar lançamentos existentes (opcional)
# Lancamento.delete_all

lancamentos = [
  { data: "2026-01-01", descricao: "mercado", valor: -131.03, fixo: false },
  { data: "2026-01-01", descricao: "Alimentação - Samuel", valor: -500, fixo: true },
  { data: "2026-01-01", descricao: "Novo Empréstimo PicpAy - 1145", valor: 4000, fixo: false },
  { data: "2026-01-01", descricao: "Carnaval (metade) 1/12", valor: 295.09, fixo: false },
  { data: "2026-01-01", descricao: "Dízimo da parcela do carro 7/15", valor: -100, fixo: false },
  { data: "2026-01-01", descricao: "Parcela do Pálio - Rafael 7/15", valor: 1000, fixo: false },
  { data: "2026-01-01", descricao: "Salário Nati", valor: 1872, fixo: true },
  { data: "2026-01-01", descricao: "Compras do Mês", valor: -621.71, fixo: true },
  { data: "2026-01-01", descricao: "Dízimo Nati", valor: -586, fixo: true },
  { data: "2026-01-01", descricao: "Dízimo Samuel", valor: -2000, fixo: true },
  { data: "2026-01-01", descricao: "Passagem Samuel", valor: -580, fixo: true },
  { data: "2026-01-01", descricao: "Salário Sam", valor: 9500, fixo: true },
  { data: "2026-01-02", descricao: "GNV (Inter)", valor: -450, fixo: true },
  { data: "2026-01-02", descricao: "Appai - Plano de Saúde", valor: -223, fixo: true },
  { data: "2026-01-02", descricao: "Sacolão Daniel", valor: -600, fixo: true },
  { data: "2026-01-02", descricao: "Internet", valor: -109, fixo: true },
  { data: "2026-01-02", descricao: "Conta de Luz", valor: -155.53, fixo: true },
  { data: "2026-01-03", descricao: "Pacote cabelo", valor: -140, fixo: true },
  { data: "2026-01-03", descricao: "Ração", valor: -75, fixo: true },
  { data: "2026-01-04", descricao: "Terapias Daniel", valor: -1260, fixo: true },
  { data: "2026-01-05", descricao: "Vitamina (neuro)", valor: -200, fixo: true },
  { data: "2026-01-05", descricao: "novo empréstimo itaú 11/52", valor: 0, fixo: false },
  { data: "2026-01-05", descricao: "Pilates", valor: 0, fixo: true },
  { data: "2026-01-07", descricao: "Condomínio", valor: -305, fixo: true },
  { data: "2026-01-07", descricao: "Alugel da casa", valor: -640, fixo: true },
  { data: "2026-01-10", descricao: "SEM PARAR (Pedágios)", valor: -100, fixo: true },
  { data: "2026-01-10", descricao: "Mensalidade escola Daniel", valor: -380, fixo: true },
  { data: "2026-01-10", descricao: "Tarifa Bradesco Sam", valor: -15.45, fixo: true },
  { data: "2026-01-20", descricao: "Seguro cartão Itaú", valor: -7.2, fixo: true }
]

lancamentos.each do |l|
  begin
    Lancamento.create!(
      descricao: l[:descricao],
      data: Date.parse(l[:data]),
      valor: l[:valor].abs,
      natureza: l[:valor] >= 0 ? :receita : :despesa,
      frequencia: l[:fixo] ? :fixo : :unico
    )
  rescue ActiveRecord::RecordInvalid => e
    puts "Erro ao criar #{l[:descricao]}: #{e.record.errors.full_messages.join(', ')}"
  end
end

puts "Seeds carregadas com sucesso!"
