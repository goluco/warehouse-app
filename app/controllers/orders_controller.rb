class OrdersController < ApplicationController
    before_action :authenticate_user!

    def new
        @order = Order.new
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end

    def create
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
        order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
        @order = Order.new(order_params)
        @order.user = current_user
        if @order.save()
          redirect_to @order, notice: "Pedido registrado com sucesso"
        else
          flash.now[:notice] = "Pedido não registrado"
          render 'new'
        end
    end

    def show
        @order = Order.find(params[:id])
    end
end