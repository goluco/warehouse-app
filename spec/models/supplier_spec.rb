require 'rails_helper'

RSpec.describe Supplier, type: :model do
    it 'falso quando o nome fantasia estiver vazio' do
      #Arrange
      supplier = Supplier.new(trade_name: '', corporate_name: 'Luis Felipe Marques', nif: "12345678901234", address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
      #Act
      result = supplier.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando a razão social estiver vazia' do
      #Arrange
      supplier = Supplier.new(trade_name: 'LF Muambas', corporate_name: '', nif: "12345678901234", address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
      #Act
      result = supplier.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando o CNPJ estiver vazio' do
      #Arrange
      supplier = Supplier.new(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: "", address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
      #Act
      result = supplier.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando o email estiver vazio' do
      #Arrange
      supplier = Supplier.new(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: "12345678901234", address: 'Rua dos Bobos, número 0', email: "", phone_number: '21998754254')
      #Act
      result = supplier.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando o CNPJ for repetido' do
      #Arrange
      supplier = Supplier.create(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: "12345678901234", address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
      supplier2 = Supplier.new(trade_name: 'Tetiiz Muambas', corporate_name: 'Arya', nif: "12345678901234", address: 'Snow Square', email: "tetiizmuamba@email.com", phone_number: '21998764274')
      #Act
      result = supplier2.valid?
      #Assert
      expect(result).to eq(false)
    end

    it 'falso quando o CNPJ não tiver 14 dígitos' do
      #Arrange
      supplier = Supplier.new(trade_name: 'LF Muambas', corporate_name: 'Luis Felipe', nif: "123456789012345", address: 'Rua dos Bobos, número 0', email: "lfmuamba@email.com", phone_number: '21998754254')
      #Act
      result = supplier.valid?
      #Assert
      expect(result).to eq(false)
    end
end
