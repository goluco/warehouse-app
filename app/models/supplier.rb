class Supplier < ApplicationRecord
    has_many :product_models
    validates :trade_name, :corporate_name, :nif, :email, presence: true
    validates :nif, uniqueness: true
    validates :nif, length: { is: 14 }
end
