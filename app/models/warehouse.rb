class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :cep, :address, :area, presence: true
  validates :name, :code, uniqueness: true
  validates :cep, format: { with: /\d{5}-\d{3}/ }
  has_many :stock_products

  def full_description
    "#{code} - #{name}"
  end
end
