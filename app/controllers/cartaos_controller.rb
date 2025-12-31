class CartaosController < ApplicationController
  before_action :set_cartao, only: [:show, :edit, :update, :destroy]

  def index
    @cartaos = Cartao.all
  end

  def show
  end

  def new
    @cartao = Cartao.new
  end

  def create
    @cartao = Cartao.new(cartao_params)
    if @cartao.save
      redirect_to cartaos_path, notice: "Cartão criado com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cartao.update(cartao_params)
      redirect_to cartaos_path, notice: "Cartão atualizado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @cartao.destroy
    redirect_to cartaos_path, notice: "Cartão removido"
  end

  private

  def set_cartao
    @cartao = Cartao.find(params[:id])
  end

  def cartao_params
    params.require(:cartao).permit(:nome, :limite)
  end
end
