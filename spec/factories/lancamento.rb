# spec/factories/lancamentos.rb
FactoryBot.define do
  factory :lancamento do
    descricao { Faker::Commerce.product_name }
    data { Date.today }
    natureza { %w[receita despesa].sample }
    valor { Faker::Commerce.price(range: 10..1000.0) }
    frequencia { "unico" }
    quantidade { nil }
  end
end
