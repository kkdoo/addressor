class AddressPoolRegenerateService
  include Concerns::HasAddressPoolRedis

  # quote: Uppercase letter "O", uppercase letter "I", lowercase letter "l", and the number "0" are excluded!
  # but we still have lowercase letter "o"?
  EXCLUDE_CHARS = ['O', 'I', 'i', '0'].freeze
  CHARSET = (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a - EXCLUDE_CHARS).freeze
  MAX_ADDRESS_SIZE = 34.freeze
  POOL_SIZE = 10

  def call
    $redis.multi do
      $redis.del(address_pool_key)
      POOL_SIZE.times do
        $redis.lpush(address_pool_key, generate_address)
      end
    end
  end

  protected
  def generate_address
    (1..MAX_ADDRESS_SIZE).map { CHARSET[rand(CHARSET.length)] }.join
  end
end
