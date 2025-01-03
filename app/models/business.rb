class Business < ApplicationRecord
  validates :name, presence: true
  
  belongs_to :account
  
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
end
