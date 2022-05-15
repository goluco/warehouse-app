class SuppliersController < ApplicationController
    def new
        @supplier = Supplier.new
    end

    def create
        @supplier = Supplier.new(supplier_params)
        if @supplier.save()
            redirect_to root_path, notice: 'Fornecedor cadastrado com sucesso'
        else
            flash.now[:notice] = 'Fornecedor não cadastrado.'
            render 'new'
        end
    end

    private

    def set_supplier 
        @supplier = Supplier.find(params[:id])
    end

    def supplier_params
        params.require(:supplier).permit(:trade_name, :corporate_name, :nif, :address, :email, :phone_number)
    end
end