require 'rails_helper'

describe 'Usuário edita um fornecedor' do
    it 'a partir da página de detalhes' do
        #Arrange
        Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        click_on 'Editar'
        #Assert
        expect(page).to have_content('Editar Fornecedor')
        expect(page).to have_field('Nome fantasia', with: 'LF Muambas')
        expect(page).to have_field('Razão social', with: 'Luis Felipe')
        expect(page).to have_field('CNPJ', with: '12345678901234')
        expect(page).to have_field('Endereço', with: 'Rua dos Bobos, número 0')
        expect(page).to have_field('email', with: 'lfmuamba@email.com')
        expect(page).to have_field('Telefone de contato', with: '21998754254')
    end

    it 'com sucesso' do
        #Arrange
        Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        click_on 'Editar'
        fill_in 'Nome fantasia', with: 'LFM Muambas'
        fill_in 'Razão social', with: 'Luis Felipe Marques'
        fill_in 'CNPJ', with: '78945612307894'
        fill_in 'Endereço', with: 'Rua dos Espertos, 1000'
        fill_in 'email', with: 'lfmarques@email.com'
        fill_in 'Telefone de contato', with: '21858647812'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Fornecedor atualizado com sucesso')
        expect(page).to have_content('LFM Muambas')
        expect(page).to have_content('Luis Felipe Marques')
        expect(page).to have_content('78945612307894')
        expect(page).to have_content('Rua dos Espertos, 1000')
        expect(page).to have_content('lfmarques@email.com')
        expect(page).to have_content('21858647812')
    end

    it 'e mantém os campos obrigatórios' do
        #Arrange
        Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        click_on 'Editar'
        fill_in 'Nome fantasia', with: ''
        fill_in 'Razão social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'email', with: ''
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Não foi possível atualizar o fornecedor.')
        expect(page).to have_content('Nome fantasia não pode ficar em branco')
        expect(page).to have_content('Razão social não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('email não pode ficar em branco')
    end

    it 'mantém CNPJ único' do
        #Arrange
        Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        Supplier.create!(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Snow Square, 123', email: "ttmuamba@email.com", phone_number: 21798754286)
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'Tetiiz Muambas'
        click_on 'Editar'
        fill_in 'Nome fantasia', with: 'LFM Muambas'
        fill_in 'Razão social', with: 'Luis Felipe Marques'
        fill_in 'CNPJ', with: '12345678901234'
        fill_in 'Endereço', with: 'Rua dos Espertos, 1000'
        fill_in 'email', with: 'lfmarques@email.com'
        fill_in 'Telefone de contato', with: '21858647812'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Não foi possível atualizar o fornecedor.')
        expect(page).to have_content('CNPJ já está em uso')
    end

    it 'mantém CNPJ com 14 caracteres' do
        #Arrange
        Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        click_on 'Editar'
        fill_in 'Nome fantasia', with: 'LFM Muambas'
        fill_in 'Razão social', with: 'Luis Felipe Marques'
        fill_in 'CNPJ', with: '123456789012348'
        fill_in 'Endereço', with: 'Rua dos Espertos, 1000'
        fill_in 'email', with: 'lfmarques@email.com'
        fill_in 'Telefone de contato', with: '21858647812'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Não foi possível atualizar o fornecedor.')
        expect(page).to have_content('CNPJ não possui o tamanho esperado (14 caracteres)')
    end
end