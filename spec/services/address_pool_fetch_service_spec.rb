require 'rails_helper'

RSpec.describe AddressPoolFetchService, type: :service do
  let(:service) { described_class.new }
  let(:address_pool_key) { service.send(:address_pool_key) }

  context '#call' do
    it 'return nil if pool is empty' do
      expect(service.call).to eq(nil)
    end

    it 'return and remove single address from the pool' do
      $redis.lpush(address_pool_key, 'address1')
      $redis.lpush(address_pool_key, 'address2')

      expect {
        expect(service.call).to eq('address2')
      }.to change { $redis.llen(address_pool_key) }.from(2).to(1)
    end
  end

  context '#address_pool_key' do
    it 'equal to "address_pool"' do
      expect(address_pool_key).to eq('address_pool')
    end
  end
end
