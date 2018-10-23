class AddressPoolFetchService
  include Concerns::HasAddressPoolRedis

  def call
    redis.lpop(address_pool_key)
  end
end
