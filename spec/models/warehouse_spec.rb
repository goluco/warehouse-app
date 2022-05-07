require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
		it 'false when name is empty' do
			#Arrange
		  warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
		  #Act
			result = warehouse.valid?
		  #Assert
			expect(result).to eq(false)
		end

		it 'false when code is empty' do
			#Arrange
		  warehouse = Warehouse.new(name: 'Rio', code: '', address: 'Endereço', cep: '25000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
		  #Act
			result = warehouse.valid?
		  #Assert
			expect(result).to eq(false)
		end

		it 'false when city is empty' do
			#Arrange
		  warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: '', area: 10000, description: 'Alguma descrição')
		  #Act
			result = warehouse.valid?
		  #Assert
			expect(result).to eq(false)
		end

		it 'false when description is empty' do
			#Arrange
		  warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio de Janeiro', area: 10000, description: '')
		  #Act
			result = warehouse.valid?
		  #Assert
			expect(result).to eq(false)
		end

		it 'false when cep is empty' do
			#Arrange
		  warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
		  #Act
			result = warehouse.valid?
		  #Assert
			expect(result).to eq(false)
		end

		it 'false when address is empty' do
			#Arrange
		  warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: '', cep: '25000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
		  #Act
			result = warehouse.valid?
		  #Assert
			expect(result).to eq(false)
		end

		it 'false when area is empty' do
			#Arrange
		  warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '25000-000', city: 'Rio de Janeiro', area: '', description: 'Alguma descrição')
		  #Act
			result = warehouse.valid?
		  #Assert
			expect(result).to eq(false)
		end

		it 'false when code is already used' do
			#Arrange
			first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
			second_warehouse = Warehouse.new(name: 'Santa Fé', code: 'RIO', address: 'Outro Endereço', cep: '15775-000', city: 'Santa Fé do Sul', area: 15000, description: 'Outra descrição')
			#Act
			result = second_warehouse.valid?
			#Assert
			expect(result).to eq(false)
		end

		it 'false when name is already used' do
			#Arrange
			first_warehouse = Warehouse.create(name: 'Rio', code: 'RIO', address: 'Endereço', cep: '20000-000', city: 'Rio de Janeiro', area: 10000, description: 'Alguma descrição')
			second_warehouse = Warehouse.new(name: 'Rio', code: 'SFS', address: 'Outro Endereço', cep: '15775-000', city: 'Santa Fé do Sul', area: 15000, description: 'Outra descrição')
			#Act
			result = second_warehouse.valid?
			#Assert
			expect(result).to eq(false)
		end

		it 'false when zip code not in the right format' do
			warehouse = Warehouse.new(name: 'Rio', code: 'SFS', address: 'Outro Endereço', cep: '15775000', city: 'Santa Fé do Sul', area: 15000, description: 'Outra descrição')
			result = warehouse.valid?
			expect(result).to eq(false)
		end

	end
end
