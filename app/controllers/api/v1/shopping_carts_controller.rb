class Api::V1::ShoppingCartsController < ApplicationController
	#GET /shoppingCarts
	def index

		@shoppingCarts = ShoppingCart
						.select("shopping_carts.products_id,shopping_carts.price, products.image, products.title,sum(shopping_carts.count)")
						.joins('INNER JOIN products ON products.id = shopping_carts.products_id')
                        .group("shopping_carts.products_id,shopping_carts.price, products.image, products.title")						
						.all
		render json: @shoppingCarts
	end

	#GET /shoppingCart/:id
	def show
		@shoppingCart = ShoppingCart.find(params[:id])
		render json:@shoppingCart
	end

	def getProductsId
		@shoppingCarts = ShoppingCart
						.select("shopping_carts.products_id,shopping_carts.price, products.image, products.title,sum(shopping_carts.count)")
						.joins('INNER JOIN products ON products.id = shopping_carts.products_id')
                        .group("shopping_carts.products_id,shopping_carts.price, products.image, products.title")
                        .where('products_id = ?',params[:id])						
						.all
		render json: @shoppingCarts
	end

	#POST /shoppingCarts
	def create
		shoppingCart = ShoppingCart.where('products_id = ?',shopping_cart_params[:products_id]).first
		if(shoppingCart.nil?)
			shoppingCart = ShoppingCart.new(shopping_cart_params)
			shoppingCart.created_at = Time.now
		else
			shoppingCart.updated_at = Time.now
			shoppingCart.count += shopping_cart_params[:count].to_i
		end
		shoppingCart.updated_at = Time.now
		if shoppingCart.save
			render json:@shoppingCart, status:200
		else
			p "error"
			p shoppingCart.errors.full_messages
			p "fin"			
			render json: {error: 'Unable to create shoppingCart'}, status:400
		end
	end

	#PUT /shoppingCarts/:id
	def update
		@shoppingCart = ShoppingCart.where('products_id = ?',params[:id]).first
		if @shoppingCart
			@shoppingCart.count = params[:_json]
			@shoppingCart.updated_at = Time.now
			@shoppingCart.save
			render json: { message: 'ShoppingCarts successfully updated.'}, status:200
		else
			render json: { error: 'Unable to update ShoppingCarts.'},status:400
		end
	end

	#DELETE /shoppingCarts/:id
	def destroy
		shoppingCart = ShoppingCart.where("products_id = ?",params[:id])
		if shoppingCart
			shoppingCart.each { |model|
				model.destroy
			}
			render json: { message: 'ShoppingCarts successfully deletd.'}, status:200
		else
			render json: { error: 'Unable to deleted ShoppingCarts.'},status:400
		end
	end

	private

	def shopping_cart_params
		params.require(:shopping_cart).permit(:price,:products_id, :count)
	end
end
