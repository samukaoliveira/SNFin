class Cartao < ApplicationRecord
    has_many :faturas, dependent: :destroy

    validates :nome, presence: true
    validates :limite, numericality: { greater_than: 0 }
    validates :fechamento,
                :vencimento,
                presence: true,
                numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 28 }
end
