class DetailSale < ApplicationRecord
  belongs_to :products
  belongs_to :sales
end
