class AddressPoolFetchService
  include Concerns::HasAddressPoolRedis

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    address = $redis.lpop(address_pool_key)
    if address
      return user.update_attributes(address: address)
    end
    false
  end
end
