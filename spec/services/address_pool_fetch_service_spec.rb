require 'rails_helper'

RSpec.describe AddressPoolFetchService, type: :service do
  let(:user) { create(:user) }
  let(:service) { described_class.new(user) }
  let(:address_pool_key) { service.send(:address_pool_key) }

  context '#call' do
    it 'return false if pool is empty' do
      expect {
        expect(service.call).to eq(false)
      }.to_not change { user.address }
    end

    it 'update address from the pool' do
      $redis.lpush(address_pool_key, 'address1')
      $redis.lpush(address_pool_key, 'address2')

      expect {
        expect(service.call).to eq(true)
      }.to change { $redis.llen(address_pool_key) }.from(2).to(1)
      expect(user.address).to eq('address2')
    end
  end

  context '#address_pool_key' do
    it 'equal to "address_pool"' do
      expect(address_pool_key).to eq('address_pool')
    end
  end
end
