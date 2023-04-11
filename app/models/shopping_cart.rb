class ShoppingCart < ApplicationRecord
  belongs_to :product, optional: true
end
