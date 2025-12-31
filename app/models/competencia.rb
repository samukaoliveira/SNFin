class Competencia < ApplicationRecord
    has_many :lancamentos

    validates :mes, :ano, presence: true    
end
