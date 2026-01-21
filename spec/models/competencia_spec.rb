# spec/models/competencia_spec.rb
require 'rails_helper'

RSpec.describe Competencia, type: :model do

  let(:user) { create(:user) }
  
  describe ".por_data" do
    it "retorna a competência correta para uma data" do
      comp = Competencia.create!(ano: 2025, mes: 4)
      data = Date.new(2025, 4, 15)
      expect(Competencia.por_data(data)).to eq(comp)
    end

    it "cria a competência se não existir" do
      data = Date.new(2025, 5, 20)
      expect {
        Competencia.por_data(data)
      }.to change(Competencia, :count).by(1)
    end
  end

  describe "#anterior" do
    it "retorna o mês anterior no mesmo ano" do
      comp = Competencia.create!(ano: 2025, mes: 5)
      anterior = comp.anterior
      expect(anterior.mes).to eq(4)
      expect(anterior.ano).to eq(2025)
    end

    it "retorna dezembro do ano anterior se for janeiro" do
      comp = Competencia.create!(ano: 2025, mes: 1)
      anterior = comp.anterior
      expect(anterior.mes).to eq(12)
      expect(anterior.ano).to eq(2024)
    end
  end

  describe "#proximo" do
    it "retorna o próximo mês no mesmo ano" do
      comp = Competencia.create!(ano: 2025, mes: 6)
      prox = comp.proxima
      expect(prox.mes).to eq(7)
      expect(prox.ano).to eq(2025)
    end

    it "retorna janeiro do próximo ano se for dezembro" do
      comp = Competencia.create!(ano: 2025, mes: 12)
      prox = comp.proxima
      expect(prox.mes).to eq(1)
      expect(prox.ano).to eq(2026)
    end
  end

  describe "#titulo" do
    it "retorna o mês e ano formatados em português" do
      comp = Competencia.create!(ano: 2025, mes: 4)
      expect(comp.titulo).to eq("Abril / 2025")
    end
  end

  describe "#nome" do
    it "retorna o mês/ano no formato MM/YYYY" do
      comp = Competencia.create!(ano: 2025, mes: 4)
      expect(comp.nome).to eq("04/2025")
    end

    it "adiciona zero à esquerda para meses menores que 10" do
      comp = Competencia.create!(ano: 2025, mes: 7)
      expect(comp.nome).to eq("07/2025")
    end

    it "não adiciona zero para meses com dois dígitos" do
      comp = Competencia.create!(ano: 2025, mes: 11)
      expect(comp.nome).to eq("11/2025")
    end
  end

  describe '#lancamentos_ate_competencia' do
    it 'retorna apenas lançamentos até o fim da competência' do
      comp = create(:competencia, ano: 2026, mes: 1)

      dentro = create(:lancamento,
        data: Date.new(2026, 1, 15),
        valor: 100,
        natureza: :receita
      )

      fora = create(:lancamento,
        data: Date.new(2026, 2, 1),
        valor: 999,
        natureza: :receita
      )

      expect(comp.lancamentos_ate_competencia).to include(dentro)
      expect(comp.lancamentos_ate_competencia).not_to include(fora)
    end
  end

  describe '#data_fim' do
    it 'retorna o último dia do mês da competência' do
      comp = Competencia.new(ano: 2026, mes: 2)
      expect(comp.data_fim).to eq(Date.new(2026, 2, 28))
    end
  end

  describe 'totais da competência' do
    it 'soma corretamente receitas e despesas' do
      comp = create(:competencia, ano: 2026, mes: 1)

      create(:lancamento, data: '2026-01-05', valor: 500, natureza: :receita)
      create(:lancamento, data: '2026-01-10', valor: 200, natureza: :despesa)
      create(:lancamento, data: '2026-02-01', valor: 999, natureza: :receita)

      expect(comp.total_receitas_previstas).to eq(500)
      expect(comp.total_despesas_previstas).to eq(200)
    end
  end

  describe '#saldo' do
    it 'retorna receitas menos despesas' do
      comp = create(:competencia, ano: 2026, mes: 1)

      create(:lancamento, data: '2026-01-05', valor: 1000, natureza: :receita)
      create(:lancamento, data: '2026-01-06', valor: 400, natureza: :despesa)

      expect(comp.saldo).to eq(600)
    end
  end

  describe '#saldo_total' do
    it 'ignora lançamentos futuros no saldo total' do
      comp = create(:competencia, ano: 2026, mes: 1)

      create(:lancamento, data: '2026-01-01', valor: 300, natureza: :receita)
      create(:lancamento, data: '2026-01-20', valor: 100, natureza: :despesa)
      create(:lancamento, data: '2026-02-01', valor: 999, natureza: :receita)

      expect(comp.saldo_total).to eq(200)
    end
  end
end
