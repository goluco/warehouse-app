require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do
    it 'ao criar um StockProduct' do
      #Arrange
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
      supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, width: 70, height: 75, depth: 80, sku: 'CDGAEIRA10JHLIO19785')
      #Act
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      #Assert
      expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado' do
      #Arrange
      user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
      other_warehouse = Warehouse.create!(name: 'SANCA', code: 'SCA', address: 'Endereço Outro', cep: '30000-000', city: 'São Carlos', area: 100001, description: 'Alguma descrição outra')
      supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: :delivered)
      product = ProductModel.create!(name: 'Cadeira Gamer', supplier: supplier, weight: 5, width: 70, height: 75, depth: 80, sku: 'CDGAEIRA10JHLIO19785')
      stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
      original_serial_number = stock_product.serial_number
      #Act
      stock_product.update(warehouse: other_warehouse)
      #Assert
      expect(stock_product.serial_number).to eq(original_serial_number)
    end
  end
end
