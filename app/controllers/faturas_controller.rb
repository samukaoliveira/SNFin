class FaturasController < ApplicationController
  before_action :set_fatura
  before_action :set_lancamento, only: %i[edit update destroy]

  def new
    @lancamento = @fatura.lancamentos.new(
      natureza: :despesa,
      frequencia: :unico
    )
  end

  def create
    @lancamento = @fatura.lancamentos.new(lancamento_params)

    if @lancamento.save
      redirect_to fatura_path(@fatura),
                  notice: "Lançamento criado com sucesso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lancamento.update(lancamento_params)
      redirect_to fatura_path(@fatura),
                  notice: "Lançamento atualizado com sucesso"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lancamento.destroy
    redirect_to fatura_path(@fatura),
                notice: "Lançamento removido"
  end

  private

  def set_fatura
    @fatura = Fatura.find(params[:fatura_id])
  end

  def set_lancamento
    @lancamento = @fatura.lancamentos.find(params[:id])
  end

  def lancamento_params
    params.require(:lancamento).permit(
      :descricao,
      :data,
      :valor,
      :natureza,
      :frequencia,
      :quantidade
    )
  end
end
