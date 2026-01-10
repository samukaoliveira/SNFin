class LancamentosController < ApplicationController
  before_action :authenticate_user!

  before_action :set_lancamento, only: [ :edit, :update, :destroy ]

  def index
    @lancamentos = TrataNulos.trata_array(
      @competencia_atual.lancamentos
                        .where(fatura_id: nil)
                        .order(:data)
    )

    # faturas da competência atual
    @faturas = Fatura
      .where(mes: @competencia_atual.mes, ano: @competencia_atual.ano)
      .includes(:cartao, :lancamentos)
  end

  def new
    @lancamento = Lancamento.new

    # 🔹 CONTEXTO DE FATURA
    if params[:fatura_id]
      @fatura = Fatura.find(params[:fatura_id])
      @lancamento.fatura = @fatura
      @lancamento.data = Date.new(@fatura.ano, @fatura.mes, 1)
    end
  end

  def create
    @lancamento = Lancamento.new(lancamento_params)

    if @lancamento.save
      redirect_to after_create_path,
                  notice: "Lançamento criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @lancamento.update(lancamento_params)
      redirect_to lancamentos_path,
                  notice: "Lançamento atualizado com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lancamento.destroy
    redirect_to lancamentos_path,
                notice: "Lançamento removido com sucesso."
  end

  def toggle_pago
    lancamento = Lancamento.find(params[:id])
    lancamento.update!(pago: !lancamento.pago)
  end

  def importar_xls
    service = LancamentoImportService.new(params[:file])
    service.call

    if service.erros.empty?
      redirect_to lancamentos_path,
                  notice: "Importação concluída com sucesso!"
    else
      redirect_to importar_lancamentos_path,
                  alert: "Erros: #{service.erros.join(', ')}"
    end
  end

  private

  def set_lancamento
    @lancamento = Lancamento.find(params[:id])
  end

  # 🔹 ÚNICA mudança real aqui
  def lancamento_params
    params.require(:lancamento).permit(
      :data,
      :natureza,
      :frequencia,
      :valor,
      :descricao,
      :fatura_id,
      :pago
    )
  end

  def after_create_path
    if @lancamento.fatura
      cartao_fatura_path(@lancamento.fatura.cartao, @lancamento.fatura)
    else
      lancamentos_path
    end
  end
end
