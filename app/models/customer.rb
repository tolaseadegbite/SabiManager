class Customer < ApplicationRecord
  validates :name, presence: true

  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  belongs_to :business
  belongs_to :account

  scope :ordered, -> { order(id: :asc) }

  private

    # Converts email to all lowercase
    def downcase_email
      email.downcase!
    end
end
