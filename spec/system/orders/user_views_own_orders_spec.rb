require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
    it 'e deve estar autenticado' do
        #Arrange
        #Act
        visit root_path
        click_on 'Meus Pedidos'
        #Assert
        expect(current_path).to eq(new_user_session_path)
    end

    it 'e não vê outros pedidos' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        other_user = User.create!(name: 'Luis Felipe', email: 'luisfelipe@email.com', password: 'other_password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        other_order = Order.create!(user: other_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 2.days.from_now)
        another_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 3.days.from_now)
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        #Assert
        expect(page).to have_content("#{order.code}")
        expect(page).to have_content("#{another_order.code}")
        expect(page).not_to have_content("#{other_order.code}")
    end

    it 'e visita um pedido' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        #Assert
        expect(page).to have_content('Detalhes do Pedido')
        expect(page).to have_content(order.code)
        expect(page).to have_content('Galpão Destino: RIO - Rio')
        expect(page).to have_content('Fornecedor: Luis Felipe Marques')
        formated_date = I18n.localize(1.day.from_now.to_date)
        expect(page).to have_content("Data Prevista de Entrega: #{formated_date}")
    end

    it 'e não visita pedidos de outros usuários' do
         #Arrange
         user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
         other_user = User.create!(name: 'Felipe', email: 'felipe@email.com', password: 'other_password')
         warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
         supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
         order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
         #Act
         login_as(other_user)
         visit order_path(order.id)
         #Assert
         expect(current_path).not_to eq(order_path(order.id))
         expect(current_path).to eq(root_path)
         expect(page).to have_content('Você não tem acesso a este pedido.')
    end
end