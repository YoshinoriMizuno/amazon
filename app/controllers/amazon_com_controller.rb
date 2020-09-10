class AmazonComController < ApplicationController

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end
    
    def create
        @product = Product.new(product_params)
        @product.user_id = current_user.id
        @product.save
    
        redirect_to root_path
    end
    
    def show
        @product = Product.find(params[:id])
        @user_product = UserProduct.all
    end

    def destroy
        @product = Product.find(params[:id])
        @product.delete
        redirect_to root_path
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
        @product.user_id = current_user.id
        @product.update(product_params)
        @product.save
        redirect_to root_path
    end

    def user_product_create
        @product = Product.find(params[:id])
        if @product.stock > 0 then
            @user_product = UserProduct.new
            @user_product.user_id = current_user.id
            @user_product.product_id = @product.id
            @user_product.lot = 1
            @user_product.save
            @product.stock = @product.stock - 1
            @product.save
            redirect_to amazon_com_path
        end
    end

    def user_product_delete
        @product = Product.find(params[:id])
        @user_product = UserProduct.new
        @user_product.user_id = current_user.id
        @user_product.product_id = @product.id
        @user_product.lot = -1
        @user_product.save
        @product.stock = @product.stock + 1
        @product.save
        redirect_to amazon_com_path
    end

    def user_product_show
        @product = Product.all
        @user_product = UserProduct.all
    end

    def user_product_show_delete
        @product = Product.find(params[:id])
        @user_product = UserProduct.new
        @user_product.user_id = current_user.id
        @user_product.product_id = @product.id
        @user_product.lot = -1
        @user_product.save
        @product.stock = @product.stock + 1
        @product.save
        redirect_to amazon_com_user_product_show_path
    end

    private
    
    def product_params
        # formから飛んできたデータをばらして入れる時
        params.require(:product).permit(:product_name,:description,:stock,:price,:user_id)
    end

end
