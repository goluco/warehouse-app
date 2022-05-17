require 'rails_helper'

describe 'Usuário cadastra modelo de produto' do
	it 'com sucesso' do
		#Arrange
		supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
		#Act
		visit root_path
		click_on 'Modelos de Produtos'
		click_on 'Cadastrar Novo'
		fill_in 'Nome', with: 'TV 40 polegadas'
		fill_in 'Peso', with: 10000
		fill_in 'Altura', with: 60
		fill_in 'Largura', with: 90
		fill_in 'Profundidade', with: 10
		fill_in 'SKU', with: 'TV-40-LFM-XPTO'
		select 'LF Muambas', from: 'Fornecedor' 
		click_on 'Enviar'
		#Assert
		expect(page).to have_content('Modelo de produto cadastrado com sucesso.')
		expect(page).to have_content('TV 40 polegadas')
		expect(page).to have_content('Fornecedor: LF Muambas')
		expect(page).to have_content('SKU: TV-40-LFM-XPTO')
		expect(page).to have_content('Dimensão: 60cm x 90cm x 10cm')
		expect(page).to have_content('Peso: 10000g')
	end
end