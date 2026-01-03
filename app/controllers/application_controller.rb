class ApplicationController < ActionController::Base
  include TrataNulos
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :definir_competencia_atual

  private

  def definir_competencia_atual
    ano = params[:ano]&.to_i || Date.current.year
    mes = params[:mes]&.to_i || Date.current.month

    @competencia_atual = Competencia.find_or_create_by!(ano: ano, mes: mes)

    @faturas = @competencia_atual.faturas
  end
end
