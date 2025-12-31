class Cartao < ApplicationRecord
    has_many :faturas, dependent: :destroy

    validates :nome, presence: true
    validates :limite, numericality: { greater_than: 0 }
end
