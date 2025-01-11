class Product < ApplicationRecord
  validates :name, :description, presence: true, length: { minimum: 5, maximum: 200 }
  validates :product_category, presence: true

  belongs_to :business, counter_cache: :products_count
  belongs_to :product_category, counter_cache: :products_count
  belongs_to :account, counter_cache: :products_count

  scope :ordered, -> { order(id: :desc) }
end
