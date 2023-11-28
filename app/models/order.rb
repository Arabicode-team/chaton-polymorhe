class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, as: :itemable

  after_create :move_line_items_from_cart

private

def move_line_items_from_cart
  cart = user.cart
  cart.line_items.update_all(itemable_id: self.id, itemable_type: 'Order')
end
end
