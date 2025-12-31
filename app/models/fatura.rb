class Fatura < ApplicationRecord
  belongs_to :cartao
  has_many :lancamentos, dependent: :destroy

  validates :mes, :ano, presence: true
end
