require 'rails_helper'

describe 'Usuário remove um fornecedor' do
    it 'com sucesso' do
        #Arrange
        Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Praça do Getúlio, 1954', email: 'lfmarcas@email.com', phone_number: 21897456432)
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        click_on 'Remover'
        #Assert 
        expect(current_path). to eq(suppliers_path)
        expect(page).to have_content('Fornecedor removido com sucesso')
    end

    it 'e não apaga outros galpões' do
        #Arrange
        Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Praça do Getúlio, 1954', email: 'lfmarcas@email.com', phone_number: 21897456432)
        Supplier.create!(trade_name: 'Tetias Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Praça do General Góes, 1955', email: 'lfmarks@email.com', phone_number: 21977458521)
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        click_on 'Remover'
        #Assert
        expect(current_path).to eq(suppliers_path)
        expect(page).not_to have_content('LF Muambas')
        expect(page).to have_content('Tetias Muambas')
        expect(page).to have_content('Fornecedor removido com sucesso')
    end
end