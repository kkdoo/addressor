class AddressPoolRegenerateService
  include Concerns::HasAddressPoolRedis

  # quote: Uppercase letter "O", uppercase letter "I", lowercase letter "l", and the number "0" are excluded!
  # but we still have lowercase letter "o"?
  EXCLUDE_CHARS = ['O', 'I', 'i'].freeze
  CHARSET = (('a'..'z').to_a + ('A'..'Z').to_a + ('1'..'9').to_a - EXCLUDE_CHARS).freeze
  MAX_ADDRESS_SIZE = 34.freeze

  def call
    redis.multi do
      redis.del(address_pool_key)
      10.times do
        redis.lpush(address_pool_key, generate_address)
      end
    end
  end

  protected
  def generate_address
    (1..MAX_ADDRESS_SIZE).map { CHARSET[rand(CHARSET.length)] }.join
  end
end
