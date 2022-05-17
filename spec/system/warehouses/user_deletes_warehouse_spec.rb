require 'rails_helper'

describe 'Usuário remove um galpão' do
    it 'com sucesso' do
        #Arrange
        w = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Remover'
        #Assert
        expect(current_path).to eq root_path
        expect(page).to have_content('Galpão removido com sucesso.')
        expect(page).not_to have_content('Rio')
        expect(page).not_to have_content('SDU')
    end

    it 'e não apaga outros galpões' do
        #Arrange
        w = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Avenida do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        w2 = Warehouse.create!(name: 'Cuiabá', code: 'CBW', city: 'Cuiabá', area: 90_000, address: 'Avenida de Cuiabá, 1500', cep: '65000-000', description: 'Galpão do centro-oeste')
        #Act
        visit root_path
        click_on 'Rio'
        click_on 'Remover'
        #Assert
        expect(current_path). to eq root_path
        expect(page).to have_content('Galpão removido com sucesso.')
        expect(page).to have_content('Cuiabá')
        expect(page).to have_content('CBW')
        expect(page).not_to have_content('Rio')
        expect(page).not_to have_content('SDU')
    end
end