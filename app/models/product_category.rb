class ProductCategory < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 200 }

  belongs_to :account
  belongs_to :business
  has_many :product_categories

  scope :ordered, -> { order(id: :desc) }
end
