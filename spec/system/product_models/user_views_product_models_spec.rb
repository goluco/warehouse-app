require 'rails_helper'

describe 'Usuário vê modelos de produtos' do
    it 'se estiver autenticado' do
        #Arrange

        #Act
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        #Assert
        expect(current_path).to eq(new_user_session_path)
    end

    it 'a partir do menu' do
        #Arrange
        user = User.create!(name: "Luis", email: "lfmarcas@email.com", password: "password")
        #Act
        login_as(user)
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        #Assert
        expect(current_path).to eq(product_models_path)
    end

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: "Luis", email: "lfmarcas@email.com", password: "password")
        supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
        ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
        ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71LFMUNOIZ7792461', supplier: supplier)
        #Act
        login_as(user)
        visit root_path
        within('nav') do
            click_on 'Modelos de Produtos'
        end
        #Assert
        expect(page).to have_content('TV 32')
        expect(page).to have_content('TV40LFMXPTO121416180')
        expect(page).to have_content('LF Muambas')
        expect(page).to have_content('SoundBar 7.1 Surround')
        expect(page).to have_content('SOU71LFMUNOIZ7792461')
        expect(page).to have_content('TV 32')
    end

    it 'e não existem produtos cadastrados' do
        #Arrange
        user = User.create!(name: "Luis", email: "lfmarcas@email.com", password: "password")
        #Act
        login_as(user)
        visit root_path
        click_on 'Modelos de Produtos'
        #Assert
        expect(page).to have_content('Não existem produtos cadastrados.')
    end
end