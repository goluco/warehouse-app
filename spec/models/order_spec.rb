require 'rails_helper'

RSpec.describe Order, type: :model do
    describe '#valid?' do
        it 'deve ter um código' do
            #Arrange
            user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
            warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
            #Act
            result = order.valid?
            #Assert
            expect(result).to be true
        end
    end

    describe 'Gera um código aleatório' do
        it 'ao criar um novo pedido' do
            #Arrange
            user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
            warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
            order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
            #Act
            order.save!
            result = order.code
            #Assert
            expect(result).not_to be_empty
            expect(result.length).to eq(8)
        end

        it 'e o código é único' do
            #Arrange
            user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
            warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
            order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
            other_order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-15')
            #Act
            other_order.save!
            result = other_order.code
            #Assert
            expect(result).not_to eq(order.code)
        end
    end
end
