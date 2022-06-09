require 'rails_helper'

describe 'Usuário adiciona itens ao pedido' do
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
        warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a cargas internacionais')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'LFM LTDA', nif: 12345678901234, address: 'Endereço do LF', email: 'lfltda@email.com', phone_number: 21978455647)
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_timne: 1.day.from_now)
        product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-A')
        product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10, height: 20, depth: 30, supplier: supplier, sku: 'PRODUTO-B')
        #Act
        login_as(user)
        visit root_path
        click_on 'Meus Pedidos'
        click_on order.code
        click_on 'Adicionar Item'
        select 'Produto A', from: 'Produto'
        fill_in 'Quantidade', with: '8'
        click_on 'Gravar'
        #Assert
        expect(current_path).to eq(order_path(order.id))
        expect(page).to have_content('Item adicionado com sucesso')
        expect(page).to have_content('8 x Produto A')
    end
end