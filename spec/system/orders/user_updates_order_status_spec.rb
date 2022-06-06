require 'rails_helper'

describe 'Usuário informa novo status do pedido' do
    it 'e o pedido foi entregue' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        other_user = User.create!(name: 'Felipe', email: 'felipe@email.com', password: 'other_password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Marcar como ENTREGUE'
        #Assert
        expect(current_path).to eq(order_path(order.id))
        expect(page).to have_content('Status: Entregue')
    end

    it 'e o pedido foi cancelado' do
         #Arrange
         user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
         other_user = User.create!(name: 'Felipe', email: 'felipe@email.com', password: 'other_password')
         warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
         supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
         order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
         #Act
         login_as(user)
         visit root_path
         click_on 'Meus Pedidos'
         click_on order.code
         click_on 'Marcar como CANCELADO'
         #Assert
         expect(current_path).to eq(order_path(order.id))
         expect(page).to have_content('Status: Cancelado')
    end
end