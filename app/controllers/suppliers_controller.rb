class SuppliersController < ApplicationController
    before_action :set_supplier, only: [:show, :edit, :update, :destroy]

    def show
    end
    
    def index
        @suppliers = Supplier.all
    end

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

    def edit
    end

    def update
        if @supplier.update(supplier_params)
            redirect_to supplier_path(@supplier.id), notice: 'Fornecedor atualizado com sucesso'
          else
            flash.now[:notice] = 'Não foi possível atualizar o fornecedor.'    
            render 'edit'
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