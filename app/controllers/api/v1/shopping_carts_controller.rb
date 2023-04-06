class Api::V1::ShoppingCartsController < ApplicationController
	#GET /shoppingCarts
	def index
		@shoppingCarts = ShoppingCarts.all
		render json: @shoppingCarts
	end

	#GET /shoppingCart/:id
	def show
		@shoppingCart = ShoppingCarts.find(params[:id])
		render json:@shoppingCart
	end

	#POST /shoppingCarts
	def create
		shoppingCart = ShoppingCarts.new(shopping_cart_params)
		p "shoppingCart"
		p shoppingCart
		p "fin"
		if shoppingCart.save
			render json:@shoppingCart
		else
			render error: {error: 'Unable to create shoppingCart'}, status:400
		end
	end

	#PUT /shoppingCarts/:id
	def update
		@shoppingCart = ShoppingCarts.find(params[:id])
		if @shoppingCart
			@shoppingCart.update(shopping_cart_params)
			render json: { message: 'ShoppingCarts successfully updated.'}, status:200
		else
			render json: { error: 'Unable to update ShoppingCarts.'},status:400
		end
	end

	#DELETE /shoppingCarts/:id
	def destroy
		@shoppingCart = ShoppingCarts.find(params[:id])
		if @shoppingCart
			@shoppingCart.destroy
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
