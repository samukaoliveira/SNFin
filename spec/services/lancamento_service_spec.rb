require 'rails_helper'

RSpec.describe LancamentoImportService, type: :service do
  let(:file) do
    fixture_file_upload(
      'organizze.xls',
      'application/vnd.ms-excel'
    )
  end

  let(:user) { create(:user) }

  subject(:call_service) { described_class.new(file).call }

  it 'importa lançamentos do arquivo' do
    expect { call_service }.to change(Lancamento, :count)
  end

  it 'importa todos os lançamentos como únicos' do
    call_service
    expect(Lancamento.pluck(:frequencia).uniq).to eq(['unico', 'fixo'])
  end

  it 'converte valores negativos em despesa com valor positivo' do
    call_service
    despesa = Lancamento.find_by(natureza: 'despesa')
    expect(despesa.valor).to be > 0
  end

  it 'mantém receitas com valor positivo' do
    call_service
    receita = Lancamento.find_by(natureza: 'receita')
    expect(receita.valor).to be > 0
  end
end
