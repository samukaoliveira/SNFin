FactoryBot.define do
  factory :cartao do
    nome { "Cartão Teste" }
    limite { 3000 }
    fechamento { 10 }
    vencimento { 20 }
  end
end
