require 'rails_helper'

RSpec.describe Cartao, type: :model do

  let(:user) { create(:user) }

  before do
    sign_in user
  end
  
  it "valida presença do nome" do
    cartao = Cartao.new
    expect(cartao).not_to be_valid
    expect(cartao.errors[:nome]).to include(I18n.t('errors.messages.blank'))
  end

  it "valida limite numérico" do
    cartao = Cartao.new(nome: "Visa", limite: -100)
    expect(cartao).not_to be_valid
  end
end
