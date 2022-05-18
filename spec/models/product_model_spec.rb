require 'rails_helper'

RSpec.describe ProductModel, type: :model do
    describe '#valid?' do
        it 'falso quando o nome estiver vazio' do
            #Arrange
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
            pm = ProductModel.new(name: '', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
            #Act
            result = pm.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando o peso estiver vazio' do
            #Arrange
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
            pm = ProductModel.new(name: 'TV 32', weight: '', width: 70, height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
            #Act
            result = pm.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando a altura estiver vazia' do
             #Arrange
             supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
             pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: '', depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
             #Act
             result = pm.valid?
             #Assert
             expect(result).to eq(false)
        end

        it 'falso quando a largura estiver vazia' do
             #Arrange
             supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
             pm = ProductModel.new(name: 'TV 32', weight: 8000, width: '', height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
             #Act
             result = pm.valid?
             #Assert
             expect(result).to eq(false)
        end

        it 'falso quando a profundidade estiver vazia' do
             #Arrange
             supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
             pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: '', sku: 'TV40LFMXPTO121416180', supplier: supplier)
             #Act
             result = pm.valid?
             #Assert
             expect(result).to eq(false)
        end

        it 'falso quando o código SKU estiver vazio' do
             #Arrange
             supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
             pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: '', supplier: supplier)
             #Act
             result = pm.valid?
             #Assert
             expect(result).to eq(false)
        end

        it 'falso quando o código SKU não tem 20 caracteres' do
            #Arrange
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
            pm = ProductModel.new(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV40LFMXPTO1214161808', supplier: supplier)
            #Act
            result = pm.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando o código SKU já está sendo utilizado' do
            #Arrange
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
            pm = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
            pm2 = ProductModel.new(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'TV40LFMXPTO121416180', supplier: supplier)
            #Act
            result = pm2.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando peso for igual ou menor que zero' do
            #Arrange
            supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
            pm = ProductModel.new(name: 'TV 32', weight: -50, width: 70, height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
            #Act
            result = pm.valid?
            #Assert
            expect(result).to eq(false)
        end

        it 'falso quando altura for igual ou menor que zero' do
             #Arrange
             supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
             pm = ProductModel.new(name: 'TV 32', weight: 50, width: 70, height: -45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
             #Act
             result = pm.valid?
             #Assert
             expect(result).to eq(false)
        end

        it 'falso quando a largura for igual ou menor que zero' do
             #Arrange
             supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
             pm = ProductModel.new(name: 'TV 32', weight: 50, width: -70, height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
             #Act
             result = pm.valid?
             #Assert
             expect(result).to eq(false)
        end

        it 'falso quando a profundidade igual ou menor que zero' do
             #Arrange
             supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
             pm = ProductModel.new(name: 'TV 32', weight: 50, width: 70, height: 45, depth: 0, sku: 'TV40LFMXPTO121416180', supplier: supplier)
             #Act
             result = pm.valid?
             #Assert
             expect(result).to eq(false)
        end
    end
end
