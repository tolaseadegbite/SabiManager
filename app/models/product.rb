class Product < ApplicationRecord
  before_save :clear_irrelevant_price_fields

  validates :name, presence: true, length: { minimum: 5, maximum: 200 }
  validates :description, length: { maximum: 200 }
  validates :product_category, presence: true
  validate :validate_price_fields

  belongs_to :business, counter_cache: :products_count
  belongs_to :product_category, counter_cache: :products_count
  belongs_to :account, counter_cache: :products_count

  scope :ordered, -> { order(id: :desc) }

  private

    def clear_irrelevant_price_fields
      if negotiable_changed?
        if negotiable?
          # If negotiable, clear fixed_price
          self.fixed_price = nil
        else
          # If non-negotiable, clear min_price and max_price
          self.min_price = nil
          self.max_price = nil
        end
      end
    end

    def validate_price_fields
      if negotiable?
        errors.add(:min_price, "can't be blank") if min_price.blank?
        errors.add(:max_price, "can't be blank") if max_price.blank?
      else
        errors.add(:fixed_price, "can't be blank") if fixed_price.blank?
      end
    end

end
