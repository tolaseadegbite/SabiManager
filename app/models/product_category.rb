class ProductCategory < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 200 }

  belongs_to :account, counter_cache: :product_categories_count
  belongs_to :business, counter_cache: :follows_count
  has_many :product_categories

  scope :ordered, -> { order(id: :desc) }
end
