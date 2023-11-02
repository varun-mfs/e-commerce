class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, processing: 1, confirmed: 2, shipped: 3, delivered: 4, canceled: 5 }
end
