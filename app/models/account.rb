class Account < ApplicationRecord
  include Rodauth::Rails.model
  enum :status, { unverified: 1, verified: 2, closed: 3 }

  has_one :profile

  has_many :businesses, dependent: :destroy
  has_many :customers, dependent: :destroy
end
