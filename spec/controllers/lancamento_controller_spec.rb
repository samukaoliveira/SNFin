require 'rails_helper'

RSpec.describe LancamentosController, type: :controller do
  let(:competencia) { create(:competencia, ano: 2025, mes: 4) }
  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  describe "GET #index" do
    it "retorna sucesso" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #new" do
    it "retorna sucesso" do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    it "cria um lançamento válido" do
      post :create, params: { lancamento: { descricao: "Teste", data: "2025-04-15", valor: 100, frequencia: :unico, natureza: :receita } }
      expect(response).to redirect_to(lancamentos_path)
      expect(Lancamento.last.descricao).to eq("Teste")
    end
  end
end
