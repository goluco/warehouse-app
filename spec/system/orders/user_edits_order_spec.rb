require 'rails_helper'

describe 'Usuário edita pedido' do
    it 'e deve estar autenticado' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        supplier2 = Supplier.create!(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Snow Square, 123', email: "ttmuamba@email.com", phone_number: 21798754286)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        visit edit_order_path(order.id)
        #Assert
        expect(current_path).to eq new_user_session_path
    end

    it 'com sucesso' do
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
        click_on 'Editar'
        fill_in 'Data Prevista de Entrega', with: '12/12/2022'
        select 'Luis Felipe Marques', from: 'Fornecedor'
        click_on 'Gravar'
        #Assert
        expect(page).to have_content('Pedido atualizado com sucesso.')
        expect(page).to have_content('Fornecedor: Luis Felipe Marques')
        expect(page).to have_content('Data Prevista de Entrega: 12/12/2022')
    end

    it 'caso não seja o responsável' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        other_user = User.create!(name: 'Felipe', email: 'felipe@email.com', password: 'other_password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        supplier2 = Supplier.create!(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Snow Square, 123', email: "ttmuamba@email.com", phone_number: 21798754286)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(other_user)
        visit edit_order_path(order.id)
        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content('Você não tem acesso a este pedido.')
    end

    it 'e o pedido está entregue ou cancelado' do
         #Arrange
         user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
         warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
         supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
         supplier2 = Supplier.create!(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Snow Square, 123', email: "ttmuamba@email.com", phone_number: 21798754286)
         order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 10)
         #Act
         login_as(user)
         visit edit_order_path(order.id)
         #Assert
         expect(page).not_to have_content('Marcar como ENTREGUE')
         expect(page).not_to have_content('Marcar como CANCELADO')
    end
end