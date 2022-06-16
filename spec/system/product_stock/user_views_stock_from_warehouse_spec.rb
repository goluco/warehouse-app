require 'rails_helper'

describe 'Usuário vê o estoque' do
  it 'na tela do galpão' do
    #Arrange
    user = User.create!(name: 'Luis', email: 'luis@email.com', password: 'password')
    warehouse = Warehouse.create(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado a cargas internacionais')
    supplier = Supplier.create!(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: 12345678901234, address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
    product_tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV40LFMXPTO121416180', supplier: supplier)
    product_soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71LFMUNOIZ7792461', supplier: supplier)
    product_notebook = ProductModel.create!(name: 'Notebook Genérico', weight: 1000, width: 50, height: 65, depth: 10, sku: 'NTB71LFMUNOIZ7792461', supplier: supplier)
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    3.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_tv) }
    2.times { StockProduct.create!(order: order, warehouse: warehouse, product_model: product_notebook) }
    #Act
    login_as(user)
    visit root_path
    click_on 'Aeroporto SP'
    #Assert
    expect(page).to have_content('Itens em Estoque')
    expect(page).to have_content('3 x TV40LFMXPTO121416180')
    expect(page).to have_content('2 x NTB71LFMUNOIZ7792461')
    expect(page).not_to have_content('SOU71LFMUNOIZ7792461')
  end
end