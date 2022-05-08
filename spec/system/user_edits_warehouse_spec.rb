require 'rails_helper'

describe 'Usuário edita um galpão' do
    it 'a partir da página de detalhes' do
        #Arrange
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Editar'
        #Assert
        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Nome', with: 'Rio')
        expect(page).to have_field('Descrição', with: 'Alguma descrição')
        expect(page).to have_field('Código', with: 'RIO')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('Endereço', with: 'Endereço')
        expect(page).to have_field('CEP', with: '20000-000')
        expect(page).to have_field('Área', with: '10000')
    end

    it 'com sucesso' do
        #Arrange
        warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Editar'
        fill_in 'Nome', with: 'Galpão do Rio'
        fill_in 'Área', with: '200000'
        fill_in 'CEP', with: '15000-000'
        fill_in 'Endereço', with: 'Outro endereço'
        click_on 'Enviar'
        #Assert
        expect(page).to have_content('Galpão atualizado com sucesso.')
        expect(page).to have_content('Nome: Galpão do Rio')
        expect(page).to have_content('CEP: 15000-000')
        expect(page).to have_content('Área: 200000')
        expect(page).to have_content('Endereço: Outro endereço')
    end

    it 'e mantém os campos obrigatórios' do
         #Arrange
         warehouse = Warehouse.create!(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
         #Act
         visit root_path
         click_on 'Rio'
         click_on 'Editar'
         fill_in 'Nome', with: ''
         fill_in 'Área', with: ''
         fill_in 'CEP', with: ''
         fill_in 'Endereço', with: ''
         click_on 'Enviar'
         #Assert
         expect(page).to have_content('Não foi possível atualizar o galpão.')
    end
end