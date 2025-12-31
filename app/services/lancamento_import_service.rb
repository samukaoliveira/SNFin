class LancamentoImportService
  require 'roo'

  attr_reader :file, :erros

  def initialize(file)
    @file = file
    @erros = []
  end

  def call
    return unless file.present?

    spreadsheet = Roo::Excel.new(file.path)
    header = spreadsheet.row(1).map(&:strip)

    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]

      begin
        data = parse_data(row['Data'])
        descricao = row['Descrição']
        valor = parse_valor(row['Valor'])
        natureza = valor >= 0 ? :receita : :despesa

        Lancamento.create!(
          data: data,
          descricao: descricao,
          valor: valor.abs,  # valor já tratado
          natureza: natureza,
          frequencia: :unico
        )
      rescue => e
        @erros << "Linha #{i}: #{e.message}"
      end
    end
    self
  end

  private

  def parse_data(data_string)
    Date.strptime(data_string.to_s, '%d.%m.%Y') rescue nil
  end

  def parse_valor(valor_string)
  # Remove apenas os pontos usados como milhares, substitui vírgula por ponto para decimais
  valor_string.to_s.strip.gsub(/(?<=\d)\.(?=\d{3}\b)/, '').gsub(',', '.').to_f
end
end
