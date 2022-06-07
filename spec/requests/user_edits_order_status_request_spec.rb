require 'rails_helper'

describe 'Usuário edita o status de um pedido sem ser o dono' do
    it 'e cancela o pedido' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        other_user = User.create!(name: 'Felipe', email: 'felipe@email.com', password: 'other_password')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #Act
        login_as(other_user)
        post(canceled_order_path(order.id))
        #Assert
        expect(response).to redirect_to(root_path)
    end

    it 'e marca como entregue' do
         #Arrange
         user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
         other_user = User.create!(name: 'Felipe', email: 'felipe@email.com', password: 'other_password')
         warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
         supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
         order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
         #Act
         login_as(other_user)
         post(delivered_order_path(order.id))
         #Assert
         expect(response).to redirect_to(root_path)
    end
end