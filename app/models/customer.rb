class Customer < ApplicationRecord
  validates :name, :phone_number, presence: true
  validates :phone_number, uniqueness: { scope: :business_id, message: "is registered to a customer"}


  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false, scope: :business_id, message: "is already registered to a customer" }

  belongs_to :business, counter_cache: :customers_count
  belongs_to :account, counter_cache: :customers_count

  scope :ordered, -> { order(id: :desc) }

  def countries
    CS.countries.with_indifferent_access
  end

  def country_label
    countries[country]
  end

  private

    # Converts email to all lowercase
    def downcase_email
      email.downcase!
    end
end
