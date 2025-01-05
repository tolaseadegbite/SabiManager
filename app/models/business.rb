class Business < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 200
 }
  
  belongs_to :account

  has_many :customers, dependent: :destroy

  scope :ordered, -> { order(id: :desc) }
  
  CURRENCIES = {
    'Nigerian Naira' => '₦',
    'US Dollar' => '$',
    'Euro' => '€',
    'British Pound' => '£',
    'Japanese Yen' => '¥'
  }.freeze
  
  def currency_symbol
    CURRENCIES[currency]
  end

  validates :currency, presence: true, inclusion: { in: CURRENCIES.keys }

  has_one_attached :logo do |attachable|
    attachable.variant :display, resize_to_limit: [200, 200]
  end

  validates :logo, content_type: { in: %w[image/jpeg image/png],
                                    message: "must be a valid image format" },
                    size:         { less_than: 1.megabytes,
                                    message:   "should be less than 1MB" }
end
