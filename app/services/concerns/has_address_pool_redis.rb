module Concerns::HasAddressPoolRedis
  extend ActiveSupport::Concern

  protected
  def address_pool_key
    'address_pool'
  end
end
