require 'rails_helper'

RSpec.describe LancamentoService, type: :service do
  let(:competencia) { create(:competencia, ano: 2025, mes: 4) }

  it "não gera lançamentos se frequência não for fixo" do
    lanc = create(:lancamento, frequencia: :unico, data: Date.new(2025,4,15), competencia: competencia)
    expect {
      LancamentoService.new(lanc).call
    }.not_to change { Lancamento.count }
  end

  it "gera lançamentos fixos corretamente mantendo dia" do
    lanc = build(:lancamento, frequencia: :fixo, data: Date.new(2025,4,15), competencia: competencia)
    expect {
      LancamentoService.new(lanc).call
    }.to change { Lancamento.count }.by(8)
    expect(Lancamento.last.data.day).to eq(15)
  end
end
