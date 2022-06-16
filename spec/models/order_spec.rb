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

        it 'falso quando a data estiver vazia' do 
            #Arrange
            order = Order.new(estimated_delivery_date: '')
            #Act
            order.valid?
            result = order.errors.include?(:estimated_delivery_date)
            #Assert
            expect(result).to be true
        end

        it 'data estimada de entrega deve ser futura' do
            #Arrange
            order = Order.new(estimated_delivery_date: 1.day.ago)
            #Act
            order.valid?
            result = order.errors.include?(:estimated_delivery_date)
            #Assert
            expect(result).to be true
            expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
        end

        it 'data estimada de entrega não deve ser igual a hoje' do
            #Arrange
            order = Order.new(estimated_delivery_date: Date.today)
            #Act
            order.valid?
            result = order.errors.include?(:estimated_delivery_date)
            #Assert
            expect(result).to be true
            expect(order.errors[:estimated_delivery_date]).to include(" deve ser futura.")
        end

        it 'data estimada de entrega deve ser igual ou maior que amanhã' do
            #Arrange
            order = Order.new(estimated_delivery_date: 1.day.from_now)
            #Act
            order.valid?
            result = order.errors.include?(:estimated_delivery_date)
            #Assert
            expect(result).to be false
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

        it 'e não deve ser modificado' do
          #Arrange
          user = User.create!(name: 'João', email: 'joao@email.com', password: 'password')
          warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
          supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
          order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)
          original_code = order.code
          #Act
          order.update!(estimated_delivery_date: 1.month.from_now)
          #Assert
          expect(order.code).to eq(original_code)
        end
    end
end
