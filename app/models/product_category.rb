class ProductCategory < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 200 }

  belongs_to :account, counter_cache: :product_categories_count
  belongs_to :business, counter_cache: :product_categories_count
  
  has_many :products, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }

  def to_combobox_display
    name # or `title`, `to_s`, etc.
  end
end
