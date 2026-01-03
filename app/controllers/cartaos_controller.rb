class CartaosController < ApplicationController
  before_action :set_cartao, only: %i[show edit update destroy]

  # GET /cartaos
  def index
    @cartaos = Cartao.order(:nome)
  end

  # GET /cartaos/:id
  def show
    # Carrega faturas ordenadas (ex: mais recentes primeiro)
    @faturas = @cartao.faturas.order(ano: :desc, mes: :desc)
  end

  # GET /cartaos/new
  def new
    @cartao = Cartao.new
  end

  # POST /cartaos
  def create
    @cartao = Cartao.new(cartao_params)

    if @cartao.save
      redirect_to cartaos_path, notice: "Cartão criado com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /cartaos/:id/edit
  def edit
  end

  # PATCH/PUT /cartaos/:id
  def update
    if @cartao.update(cartao_params)
      redirect_to cartaos_path, notice: "Cartão atualizado com sucesso"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cartaos/:id
  def destroy
    @cartao.destroy
    redirect_to cartaos_path, notice: "Cartão removido com sucesso"
  end

  private

  def set_cartao
    @cartao = Cartao.find(params[:id])
  end

  def cartao_params
    params.require(:cartao).permit(:nome, :limite)
  end
end
