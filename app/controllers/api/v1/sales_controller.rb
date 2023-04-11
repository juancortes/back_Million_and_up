class Api::V1::SalesController < ApplicationController
	#GET /sales
	def index
		@sales = Sale.all
		render json: @sales
	end

	#GET /sale/:id
	def show
		@sale = Sale.find(params[:id])
		render json:@sale
	end

	#POST /sales
	def create
		shoppingCart = ShoppingCart.all
		if shoppingCart.count > 0 
			total_amount = 0
			shoppingCart.each { |sc|
				total_amount += sc.count
			}
			sale = Sale.new
			sale.total_amount = total_amount
			sale.created_at = Time.now
			sale.updated_at = Time.now
			if sale.save
				shoppingCart.each { |sc|
					detalle = DetailSale.new
					detalle.products_id = sc.products_id
					detalle.count = sc.count
					detalle.price = sc.price
					detalle.sales_id = sale.id
					detalle.created_at = Time.now
					detalle.updated_at = Time.now
					detalle.save
				}
				shoppingCart.delete_all 
				render json:@sale
			else
				render error: {error: 'Unable to create sale'}, status:400
			end
		end
	end

	#PUT /sales/:id
	def update
		@sale = Sale.find(params[:id])
		if @sale
			@sale.update(sale_params)
			render json: { message: 'Sale successfully updated.'}, status:200
		else
			render json: { error: 'Unable to update Sale.'},status:400
		end
	end

	#DELETE /sales/:id
	def destroy
		p "si"
		@sale = Sale.find(params[:id])
		if @sale
			@sale.destroy
			render json: { message: 'Sale successfully deletd.'}, status:200
		else
			render json: { error: 'Unable to deleted Sale.'},status:400
		end
	end

	def getCountSaleByProductsId
		shoppingCarts = DetailSale
						.select("sum(count)")
                        .where('products_id = ?',params[:id])						
						.all
		render json: shoppingCarts
	end

	private

	def sale_params
		params.require(:sale).permit()
	end
end
