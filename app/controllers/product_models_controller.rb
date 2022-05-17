class ProductModelsController < ApplicationController
    def index
        @product_models = ProductModel.all
    end

    def show
    end
end