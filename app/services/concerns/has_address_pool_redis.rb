module Concerns::HasAddressPoolRedis
  extend ActiveSupport::Concern

  protected
  def address_pool_key
    'address_pool'
  end

  #TODO: use ConnectionPool
  def redis
    Redis.new(db: db_name)
  end

  def db_name
    ['addressor', Rails.env].join('-')
  end
end
