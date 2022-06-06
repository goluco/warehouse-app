require 'rails_helper'

describe 'Usuário cadastra um pedido' do
    it 'e deve estar autenticado' do
        #Arrange
        #Act
        visit root_path
        click_on 'Registrar pedido'
        #Assert
        expect(current_path).to eq(new_user_session_path)
    end
    
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Jose Carlos', email: 'josecarlos@email.com', password: 'senhanova')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        other_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a cargas internacionais')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        other_supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 22345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABCD1234')
        #Act
        visit root_path
        login_as(user)
        click_on 'Registrar pedido'
        select 'RIO - Rio', from: 'Galpão Destino' 
        select supplier.corporate_name, from: 'Fornecedor'
        fill_in 'Data Prevista de Entrega', with: '20/12/2022'
        click_on 'Gravar'
        #Assert
        expect(page).to have_content('Pedido registrado com sucesso')
        expect(page).to have_content('Pedido ABCD1234')
        expect(page).to have_content('Galpão Destino: RIO - Rio')
        expect(page).to have_content('Fornecedor: Luis Felipe Marques')
        expect(page).to have_content('Usuário responsável: Jose Carlos - josecarlos@email.com')
        expect(page).to have_content('Data Prevista de Entrega: 20/12/2022')
        expect(page).to have_content('Status: Pendente')
        expect(page).not_to have_content('Galpão Destino: Aeroporto SP')
        expect(page).not_to have_content('Fornecedor: LF Muambas')
    end

    it 'com a data em branco' do
        #Arrange
        user = User.create!(name: 'Jose Carlos', email: 'josecarlos@email.com', password: 'senhanova')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        other_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a cargas internacionais')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        other_supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 22345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        #Act
        login_as(user)
        visit root_path
        click_on 'Registrar pedido'
        select 'RIO - Rio', from: 'Galpão Destino' 
        select supplier.corporate_name, from: 'Fornecedor'
        fill_in 'Data Prevista de Entrega', with: ''
        click_on 'Gravar'
        #Assert
        expect(page).to have_content('Pedido não registrado')
        expect(page).to have_content('Data Prevista de Entrega não pode ficar em branco')
    end

    it 'com a data num período não aceitável' do
        #Arrange
        user = User.create!(name: 'Jose Carlos', email: 'josecarlos@email.com', password: 'senhanova')
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        other_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a cargas internacionais')
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        other_supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 22345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        #Act
        login_as(user)
        visit root_path
        click_on 'Registrar pedido'
        select 'RIO - Rio', from: 'Galpão Destino' 
        select supplier.corporate_name, from: 'Fornecedor'
        fill_in 'Data Prevista de Entrega', with: 1.day.ago
        click_on 'Gravar'
        #Assert
        expect(page).to have_content('Pedido não registrado')
        expect(page).to have_content('Data Prevista de Entrega deve ser futura.')
    end
end