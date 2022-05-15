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
        fill_in 'CNPJ', with: '12345678901234'
        fill_in 'Endereço', with: 'Rua dos Bobos, número 0'
        fill_in 'email', with: 'lfmarquesf@email.com'
        fill_in 'Telefone de contato', with: '21987546625'
        click_on 'Enviar'
        #Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content('Fornecedor cadastrado com sucesso')
    end

    it 'com dados incompletos' do
        #Arrange

        #Act
        visit root_path
        click_on 'Cadastrar fornecedor'
        fill_in 'Nome fantasia', with: ''
        fill_in 'Razão social', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: 'Rua dos Bobos, número 0'
        fill_in 'email', with: ''
        fill_in 'Telefone de contato', with: '21987546625'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Fornecedor não cadastrado.'
        expect(page).to have_content 'Razão social não pode ficar em branco'
        expect(page).to have_content 'CNPJ não pode ficar em branco'
        expect(page).to have_content 'email não pode ficar em branco'
    end

    it 'com CNPJ repetido' do
        #Arrange
        Supplier.create(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: "12345678901234", address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
        #Act
        visit root_path
        click_on 'Cadastrar fornecedor'
        fill_in 'Nome fantasia', with: 'Tetiiz Muambas'
        fill_in 'Razão social', with: 'Arya'
        fill_in 'CNPJ', with: "12345678901234"
        fill_in 'Endereço', with: 'Largo das Neves'
        fill_in 'email', with: 'tetiizmuambas@email.com'
        fill_in 'Telefone de contato', with: '21985643321'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Fornecedor não cadastrado.'
        expect(page).to have_content 'CNPJ já está em uso'
    end

    it 'com CNPJ incorreto' do
        #Arrange
        
        #Act
        visit root_path
        click_on 'Cadastrar fornecedor'
        fill_in 'Nome fantasia', with: 'Tetiiz Muambas'
        fill_in 'Razão social', with: 'Arya'
        fill_in 'CNPJ', with: "123456789012344"
        fill_in 'Endereço', with: 'Largo das Neves'
        fill_in 'email', with: 'tetiizmuambas@email.com'
        fill_in 'Telefone de contato', with: '21985643321'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content 'Fornecedor não cadastrado.'
        expect(page).to have_content 'CNPJ não possui o tamanho esperado (14 caracteres)'
    end
end