class Api::V1::ProductsController < ApplicationController
	#GET /products
	def index
		@products = Product.all
		render json: @products
	end

	#GET /product/:id
	def show
		product = Product.find(params[:id])
		render json:product
	end

	#POST /products
	def create
		@product = Product.new(product_params)
		if @product.save
			render json:@product
		else
			render error: {error: 'Unable to create product'}, status:400
		end
	end

	#PUT /products/:id
	def update
		@product = Product.find(params[:id])
		if @product
			@product.update(product_params)
			render json: { message: 'Product successfully updated.'}, status:200
		else
			render json: { error: 'Unable to update Product.'},status:400
		end
	end

	#DELETE /products/:id
	def destroy
		@product = Product.find(params[:id])
		if @product
			@product.destroy
			render json: { message: 'Product successfully deletd.'}, status:200
		else
			render json: { error: 'Unable to deleted Product.'},status:400
		end
	end

	private

	def product_params
		params.require(:products).permit()
	end
end
