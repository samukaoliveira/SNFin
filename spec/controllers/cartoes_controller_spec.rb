# spec/controllers/cartaos_controller_spec.rb
require 'rails_helper'

RSpec.describe CartaosController, type: :controller do
  let!(:cartao) { create(:cartao) }

  describe "GET #index" do
    it "retorna sucesso" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(assigns(:cartaos)).to include(cartao)
    end
  end

  describe "GET #show" do
    it "mostra um cartão existente" do
      get :show, params: { id: cartao.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:cartao)).to eq(cartao)
    end
  end

  describe "GET #new" do
    it "instancia um novo cartão" do
      get :new
      expect(response).to have_http_status(:ok)
      expect(assigns(:cartao)).to be_a_new(Cartao)
    end
  end

  describe "POST #create" do
    context "com parâmetros válidos" do
      it "cria um novo cartão" do
        expect {
          post :create, params: { cartao: { nome: "Visa", limite: 1000,
                                            fechamento: 25, vencimento: 8 } }
        }.to change(Cartao, :count).by(1)
        expect(response).to redirect_to(cartaos_path)
      end
    end

    context "com parâmetros inválidos" do
      it "não cria cartão e renderiza new" do
        expect {
          post :create, params: { cartao: { nome: "", limite: -10 } }
        }.not_to change(Cartao, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "retorna sucesso" do
      get :edit, params: { id: cartao.id }
      expect(response).to have_http_status(:ok)
      expect(assigns(:cartao)).to eq(cartao)
    end
  end

  describe "PATCH #update" do
    context "com parâmetros válidos" do
      it "atualiza o cartão" do
        patch :update, params: { id: cartao.id, cartao: { limite: 2000 } }
        expect(cartao.reload.limite).to eq(2000)
        expect(response).to redirect_to(cartaos_path)
      end
    end

    context "com parâmetros inválidos" do
      it "não atualiza o cartão" do
        patch :update, params: { id: cartao.id, cartao: { limite: -50 } }
        expect(cartao.reload.limite).not_to eq(-50)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "remove o cartão" do
      expect {
        delete :destroy, params: { id: cartao.id }
      }.to change(Cartao, :count).by(-1)
      expect(response).to redirect_to(cartaos_path)
    end
  end
end
