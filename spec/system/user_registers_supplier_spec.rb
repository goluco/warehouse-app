require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
    it 'a partir da tela inicial' do
        #Arrange
        #Act
        visit root_path
        click_on 'Cadastrar fornecedor'
        #Assert
        expect(page).to have_field('Nome fantasia')
        expect(page).to have_field('Razão social')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('email')
        expect(page).to have_field('Telefone de contato')
    end

    it 'com sucesso' do
        #Arrange
        #Act
        visit root_path
        click_on 'Cadastrar fornecedor'
        fill_in 'Nome fantasia', with: 'LF Muambas'
        fill_in 'Razão social', with: 'Luis Felipe Marques'
        fill_in 'CNPJ', with: '12345678901-234'
        fill_in 'Endereço', with: 'Rua dos Bobos, número 0'
        fill_in 'email', with: 'lfmarquesf@email.com'
        fill_in 'Telefone de contato', with: '21-987546625'
        click_on 'Enviar'
        #Assert
    end

    it 'com dados incompletos' do
        #Arrange

        #Act
        visit root_path
        click_on 'Cadastrar fornecedor'
        fill_in 'Nome fantasia', with: 'LF Muambas'
        fill_in 'Razão social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: 'Rua dos Bobos, número 0'
        fill_in 'email', with: ''
        fill_in 'Telefone de contato', with: '21-987546625'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Fornecedor não cadastrado.'
        expect(page).to have_content 'Razão social não pode ficar em branco'
        expect(page).to have_content 'CNPJ não pode ficar em branco'
        expect(page).to have_content 'email não pode ficar em branco'
    end

    it 'com formatação incorreta' do
        #Arrange
        Supplier.create(trade_name: )
        #Act
        #Assert
    end
end