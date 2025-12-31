# spec/models/competencia_spec.rb
require 'rails_helper'

RSpec.describe Competencia, type: :model do
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
end
