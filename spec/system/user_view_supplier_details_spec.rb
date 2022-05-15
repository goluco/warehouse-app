require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
    it 'e vê todas as informações' do
        #Arrange
        Supplier.create(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        #Assert
        expect(page).to have_content('Nome fantasia: LF Muambas')
        expect(page).to have_content('Razão social: Luis Felipe')
        expect(page).to have_content('CNPJ: 12345678901234')
        expect(page).to have_content('Endereço: Rua dos Bobos, número 0')
        expect(page).to have_content('email: lfmuamba@email.com')
        expect(page).to have_content('Telefone para contato: 21998754254')
    end

    it 'e retorna ao Menu inicial' do
        #Arrange
        Supplier.create(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
        #Act
        visit root_path
        click_on 'Fornecedores'
        click_on 'LF Muambas'
        click_on 'Voltar para a tela inicial'
        #Assert    
        expect(current_path).to eq('/')
    end
end