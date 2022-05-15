require 'rails_helper'

describe 'Usuário visita tela de fornecedores' do
    it 'vê o título da tela' do
        #Arrange

        #Act
        visit(root_path)
        click_on 'Fornecedores'
        #Assert
        expect(current_path).to eq(suppliers_path)
        expect(page).to have_content('Lista de fornecedores')
    end

    it 'vê os fornecedores cadastrados' do
        #Arrange
        Supplier.create(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: "Fool's Street", email: 'lfmarques@email.com', phone_number: 21978985623)
        Supplier.create(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: "Snow Square", email: 'tetiiz@email.com', phone_number: 21956412235)
        #Act
        visit(root_path)
        click_on 'Fornecedores'
        #Assert
        expect(current_path).to eq(suppliers_path)
        expect(page).not_to have_content('Não existem fornecedores cadastrados.')
        expect(page).to have_content('LF Muambas')
        expect(page).to have_content('Tetiiz Muambas')
    end

    it 'não existem fornecedores cadastrados' do
        #Arrange

        #Act
        visit(root_path)
        click_on 'Fornecedores'
        #Assert
        expect(page).to have_content('Não existem fornecedores cadastrados.')
    end
end