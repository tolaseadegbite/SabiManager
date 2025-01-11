class Product < ApplicationRecord
  validates :name, :product_category_id, presence: true, length: { min: 5, maximum: 200 }
  validates :description, length: { maximum: 200 }

  belongs_to :business, counter_cache: :products_count
  belongs_to :product_category, counter_cache: :products_count
  belongs_to :account, counter_cache: :products_count

  scope :ordered, -> { order(id: :desc) }
end
