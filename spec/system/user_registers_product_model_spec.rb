require 'rails_helper'

describe 'Usuário cadastra modelo de produto' do
	it 'com sucesso' do
		#Arrange
		supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
		supplier2 = Supplier.create!(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Snow Square, 123', email: "ttmuamba@email.com", phone_number: 21798754286)
		#Act
		visit root_path
		click_on 'Modelos de Produtos'
		click_on 'Cadastrar Novo'
		fill_in 'Nome', with: 'TV 40 polegadas'
		fill_in 'Peso', with: 10000
		fill_in 'Altura', with: 60
		fill_in 'Largura', with: 90
		fill_in 'Profundidade', with: 10
		fill_in 'SKU', with: 'TV40LFMXPTO121416180'
		select 'LF Muambas', from: 'Fornecedor' 
		click_on 'Enviar'
		#Assert
		expect(page).to have_content('Modelo de produto cadastrado com sucesso.')
		expect(page).to have_content('TV 40 polegadas')
		expect(page).to have_content('Fornecedor: LF Muambas')
		expect(page).to have_content('SKU: TV40LFMXPTO121416180')
		expect(page).to have_content('Dimensão: 60cm x 90cm x 10cm')
		expect(page).to have_content('Peso: 10000g')
	end

	it 'com campos incorretos' do
		#Arrange
		supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
		supplier2 = Supplier.create!(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Snow Square, 123', email: "ttmuamba@email.com", phone_number: 21798754286)
		ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71LFMUNOIZ7792461', supplier: supplier)
		#Act
		visit root_path
		click_on 'Modelos de Produtos'
		click_on 'Cadastrar Novo'
		fill_in 'Nome', with: ''
		fill_in 'Peso', with: 0
		fill_in 'Altura', with: -50
		fill_in 'Largura', with: 90
		fill_in 'Profundidade', with: 10
		fill_in 'SKU', with: 'SOU71LFMUNOIZ7792461'
		select 'LF Muambas', from: 'Fornecedor' 
		click_on 'Enviar'
		#Assert
		expect(page).to have_content('Não foi possível cadastrar o modelo de produto.')
		expect(page).to have_content('Nome não pode ficar em branco')
		expect(page).to have_content('Peso deve ser maior que 0')
		expect(page).to have_content('Altura deve ser maior que 0')
		expect(page).to have_content('SKU já está em uso')


	end

	it 'com código de tamanho incorreto' do
		#Arrange
		supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe Marques', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: 21998754254)
		supplier2 = Supplier.create!(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: 23456789012345, address: 'Snow Square, 123', email: "ttmuamba@email.com", phone_number: 21798754286)
		#Act
		visit root_path
		click_on 'Modelos de Produtos'
		click_on 'Cadastrar Novo'
		fill_in 'Nome', with: 'TV 40 polegadas'
		fill_in 'Peso', with: 10000
		fill_in 'Altura', with: 60
		fill_in 'Largura', with: 90
		fill_in 'Profundidade', with: 10
		fill_in 'SKU', with: 'TV40LFMXPTO12141618032'
		select 'LF Muambas', from: 'Fornecedor' 
		click_on 'Enviar'
		#Assert
		expect(page).to have_content('Não foi possível cadastrar o modelo de produto.')
		expect(page).to have_content('SKU não possui o tamanho esperado (20 caracteres)')
	end
end