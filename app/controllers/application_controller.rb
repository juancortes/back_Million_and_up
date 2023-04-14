class ApplicationController < ActionController::API
	require "uri"
  require "net/http"
  require "json"
  before_action :get_data

  def get_data
  	products = Product.all
  	if products.count == 0
  		begin
	      url = URI("#{Rails.configuration.urlProducts}")

	      https = Net::HTTP.new(url.host, url.port)
				https.use_ssl = true

				request = Net::HTTP::Get.new(url)

				response = https.request(request)
	      

	      object = JSON.parse(response.read_body, object_class: OpenStruct)

	   		object.each{ |obj|
	   			product = Product.new
	   			product.title = obj.title
	   			product.price = obj.price
	   			product.description = obj.description
	   			product.category = obj.category
	   			product.image = obj.image
	   			product.rate = obj.rating.rate
	   			product.count = obj.rating.count
		      product.save

	   		}

	   		url   = URI("#{Rails.configuration.urlProducts2}")
		  	https = Net::HTTP.new(url.host, url.port)
				https.use_ssl = true
				request = Net::HTTP::Get.new(url)
				response = https.request(request)
		    object = JSON.parse(response.read_body, object_class: OpenStruct)
		 		object[:products].each{ |obj|
		 			product = Product.new
	   			product.title = obj.title
	   			product.price = obj.price
	   			product.description = obj.description
	   			product.category = obj.category
	   			product.image = obj.thumbnail
	   			product.rate = obj.rating
	   			product.count = obj.stock
		      product.save
		 		}

	      rescue => e
	        puts "failed error = #{e}"
	    end
  	end

    


  end
end
