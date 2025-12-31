module TrataNulos
  extend ActiveSupport::Concern

  private

  def self.trata_nulos(valor, padrao = "Vazio")
    valor.presence || padrao
  end

  def self.trata_array(valor)
    valor.presence || []
  end

  def self.trata_hash(valor)
    valor.presence || {}
  end
end
