require 'rails_helper'

describe 'Warehouse API' do
  context 'GET/api/v1/warehouses/1' do
    it 'successo' do
      # Arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a cargas internacionais')
      # Act
      get "/api/v1/warehouses/#{warehouse.id}"
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('GRU')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
    end

    it 'falha se o galpão não for encontrado' do
      # Act
      get '/api/v1/warehouses/99999999999'
      # Assert
      expect(response.status).to eq 404 
    end
  end
  context 'GET/api/v1/warehouses' do
    it 'successo' do
      # Arrange
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a cargas internacionais')
      other_warehouse = Warehouse.create!(name: 'Aeroporto RJ', code: 'SDU', city: 'Rio de Janeiro', area: 50_000, address: 'Avenida do Aeroporto, 5000', cep: '25000-000', description: 'Galpão destinado a cargas fluminenses')
      # Act
      get '/api/v1/warehouses'
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2 
      expect(json_response[0]['name']).to eq("#{warehouse.name}")
      expect(json_response[1]['name']).to eq("#{other_warehouse.name}")
    end

    it 'retorna vazio caso não existam galpões' do
      # Act
      get '/api/v1/warehouses'
      # Assert
      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 0
    end

    it 'e levanta erro interno' do
      # Arrange
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)
      # Act
      get '/api/v1/warehouses'
      # Assert
      expect(response).to have_http_status(500)
    end
  end

  context 'POST/api/v1/warehouses' do
    it 'success' do
      # Arrange
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Alguma descrição' } }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      expect(response).to have_http_status(:created)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Aeroporto SP')
      expect(json_response['code']).to eq('GRU')
      expect(json_response['city']).to eq('Guarulhos')
      expect(json_response['area']).to eq(100_000)
      expect(json_response['cep']).to eq('15000-000')
      expect(json_response['description']).to eq('Alguma descrição')
    end

    it 'falha se os parâmetros não estão completos' do
      # Arrange
      warehouse_params = { warehouse: {name: 'Aeroporto Curitiba', code: 'CTB'} }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      expect(response).to have_http_status(412)
      expect(response.body).to include 'Cidade não pode ficar em branco'
      expect(response.body).to include 'Área não pode ficar em branco'
      expect(response.body).to include 'CEP não pode ficar em branco'
      expect(response.body).to include 'Descrição não pode ficar em branco'
    end

    it 'falha se há erro interno' do
      # Arrange
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Alguma descrição' } }
      # Act
      post '/api/v1/warehouses', params: warehouse_params
      # Assert
      expect(response).to have_http_status(500)
    end
  end
end