class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :address, length: {minimum: 34, maximum: 34}, allow_nil: true
  validate :validate_address_charset

  def validate_address_charset
    return if address.nil?
    unless /^[a-zA-Z0-9]*$/.match?(address) && (address.chars & AddressPoolRegenerateService::EXCLUDE_CHARS).empty?
      errors.add(:address, 'should be only letters or digits, but with "O", "I", "i" and "0" excluded')
    end
  end
end
