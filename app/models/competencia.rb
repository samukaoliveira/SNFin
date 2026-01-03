class Competencia < ApplicationRecord
    has_many :lancamentos, dependent: :destroy

    validates :ano, :mes, presence: true
    validates :mes, inclusion: { in: 1..12 }

    def titulo
        I18n.l(Date.new(ano, mes, 1), format: "%B / %Y")
    end

    def anterior
        data = Date.new(ano, mes, 1).prev_month
        cria_competencia(data)
    end

    def proxima
        data = Date.new(ano, mes, 1).next_month
        cria_competencia(data)
    end

    def cria_competencia(data)
        Competencia.find_or_create_by!(ano: data.year, mes: data.month)
    end

    def self.por_data(data)
        find_or_create_by!(
        ano: data.year,
        mes: data.month
        )
    end  

    def nome
      "#{mes.to_s.rjust(2, '0')}/#{ano}"
    end

    def total_receitas
        filtra_e_soma(lancamentos, :receita)
    end

    def total_despesas
        filtra_e_soma(lancamentos, :despesa)
    end

    def saldo
        total_receitas - total_despesas
    end

    def filtra_e_soma(valores, natureza)
        valores.filter { |v| v.natureza.to_sym == natureza }.sum(&:valor)
    end

    def saldo_total
        todas_as_receitas_cadastradas - todas_as_despesas_cadastradas
    end

    def todas_as_receitas_cadastradas
        filtra_e_soma(lancamentos_ate_competencia, :receita)
    end

    def todas_as_despesas_cadastradas
        filtra_e_soma(lancamentos_ate_competencia, :despesa)
    end

    def data_fim
        Date.new(ano, mes, 1).end_of_month
    end

    def lancamentos_ate_competencia
        Lancamento.where('data <= ?', data_fim)
    end

    def faturas
        Cartao.all.map do |cartao|
        Fatura.find_or_create_by!(
            cartao: cartao,
            mes: mes,
            ano: ano
        )
        end
    end
end
