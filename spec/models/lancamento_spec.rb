# spec/models/lancamento_spec.rb
require 'rails_helper'

RSpec.describe Lancamento, type: :model do
    it "não permite valor negativo" do
        lanc = Lancamento.new(valor: -10, data: Date.today, frequencia: "unico", natureza: "receita")
        expect(lanc).not_to be_valid
    end

    it "gera lançamentos fixos para os próximos meses" do
        lanc = build(:lancamento, frequencia: :fixo, data: Date.new(2025,4,15)) # build, não create

        expect {
            LancamentoService.new(lanc).call
        }.to change { Lancamento.count }.by(8)
    end
end
