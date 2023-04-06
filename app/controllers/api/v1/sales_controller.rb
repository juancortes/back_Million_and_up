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
		@sale = Sale.new(sale_params)
		if @sale.save
			render json:@sale
		else
			render error: {error: 'Unable to create sale'}, status:400
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
		@sale = Sale.find(params[:id])
		if @sale
			@sale.destroy
			render json: { message: 'Sale successfully deletd.'}, status:200
		else
			render json: { error: 'Unable to deleted Sale.'},status:400
		end
	end

	private

	def sale_params
		params.require(:sales).permit()
	end
end
