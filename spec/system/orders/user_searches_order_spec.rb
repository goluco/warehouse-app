require 'rails_helper'

describe 'Usuário busca por um pedido' do
    it 'a partir do menu' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        #Act
        login_as(user)
        visit root_path
        #Assert
        within('header nav') do
            expect(page).to have_field('Buscar pedido')
            expect(page).to have_button('Buscar')
        end
    end

    it 'e deve estar autenticado' do
        #Arrange
        #Act
        visit root_path
        #Assert
        within('header nav') do
            expect(page).not_to have_field('Buscar pedido')
            expect(page).not_to have_button('Buscar')
        end
    end

    it 'e encontra um pedido' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        fill_in 'Buscar pedido', with: order.code
        click_on 'Buscar'
        #Assert
        expect(page).to have_content("Resultados da Busca por: #{order.code}")
        expect(page).to have_content('1 pedido encontrado')
        expect(page).to have_content("Código: #{order.code}")
        expect(page).to have_content("Galpão Destino: #{order.warehouse.full_description}")
        expect(page).to have_content("Fornecedor: #{order.supplier.trade_name}")
    end

    it 'e encontra múltiplos pedidos' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        other_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'CGH', address: 'Outro Endereço', cep: '60500-000', city: 'São Paulo', area: 20000, description: 'Alguma outra descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('RIO12345')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('RIO54321')
        other_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('CGH77854')
        another_order = Order.create!(user: user, warehouse: other_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        fill_in 'Buscar pedido', with: 'RIO'
        click_on 'Buscar' 
        #Assert
        expect(page).to have_content('2 pedidos encontrados')
        expect(page).to have_content('RIO12345')
        expect(page).to have_content('RIO54321')
        expect(page).to have_content('Galpão Destino: RIO - Rio')
        expect(page).not_to have_content('CGH77854')
        expect(page).not_to have_content('Galpão Destino: CGH - Aeroporto SP')
    end
end