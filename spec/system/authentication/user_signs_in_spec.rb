require 'rails_helper'

describe 'Usuário se autentica' do
    it 'com sucesso' do
        #Arrange
        User.create!(name: 'Luis Felipe', email: 'lfmarcas@email.com', password: 'password')
        #Act
        visit root_path
        click_on 'Entrar'
        within('form') do
          fill_in 'Email', with: 'lfmarcas@email.com'
          fill_in 'Senha', with: 'password'
          click_on 'Entrar'
        end
        #Assert
        within('nav') do 
            expect(page).not_to have_link 'Entrar'
            expect(page).to have_button 'Sair'
            expect(page).to have_content('Luis Felipe - lfmarcas@email.com')
        end
        expect(page).to have_content('Login efetuado com sucesso.')
    end

    it 'e faz logout' do
        #Arrange
        User.create!(email: 'lfmarcas@email.com', password: 'password')
        #Act
        visit root_path
        click_on 'Entrar'
        fill_in 'Email', with: 'lfmarcas@email.com'
        fill_in 'Senha', with: 'password'
        within('form') do
            click_on 'Entrar'
        end
        click_on 'Sair'
        #Assert
        expect(page).to have_content('Logout efetuado com sucesso.')
        expect(page).to have_link('Entrar')
        expect(page).not_to have_button('Sair')
        expect(page).not_to have_content('lfmarcas@email.com')
    end
end