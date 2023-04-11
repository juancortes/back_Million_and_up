class DetailSale < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :sale, optional: true
end
