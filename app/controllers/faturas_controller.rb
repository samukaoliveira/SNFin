class FaturasController < ApplicationController

    before_action :set_fatura

  def show
  end

  private

  def set_fatura
    @fatura = Fatura.find(params[:id])
  end

end
