class Photo < ApplicationRecord
    has_many :line_items
    has_many :carts, through: :line_items, source: :itemable, source_type: 'Cart'
    has_many :orders, through: :line_items, source: :itemable, source_type: 'Order'
  end
  