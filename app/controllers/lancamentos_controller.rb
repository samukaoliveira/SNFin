class LancamentosController < ApplicationController
  before_action :set_lancamento, only: [:edit, :update, :destroy]

  def index
    @lancamentos = TrataNulos.trata_array(@competencia_atual.lancamentos.order(:data))
  end

  def new
    @lancamento = Lancamento.new
  end

  def create
    @lancamento = Lancamento.new(lancamento_params)

    if @lancamento.save
      redirect_to lancamentos_path, notice: "Lançamento criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lancamento.update(lancamento_params)
      redirect_to lancamentos_path, notice: "Lançamento atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lancamento.destroy
    redirect_to lancamentos_path, notice: "Lançamento removido com sucesso."
  end

  private

  def set_lancamento
    @lancamento = Lancamento.find(params[:id])
  end

  def lancamento_params
    params.require(:lancamento).permit(:data, :natureza, :frequencia, :valor, :descricao)
  end
end
