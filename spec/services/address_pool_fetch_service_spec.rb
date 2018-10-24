require 'rails_helper'

RSpec.describe AddressPoolFetchService, type: :service do
  let(:user) { create(:user) }
  let(:service) { described_class.new(user) }
  let(:address_pool_key) { service.send(:address_pool_key) }

  context '#call' do
    it 'assign error if pool is empty' do
      expect {
        service.call
      }.to_not change { user.address }
      expect(service.error).to match(/Address Pool empty, please try again/)
    end

    it 'update address from the pool' do
      $redis.lpush(address_pool_key, 'a'*34)
      $redis.lpush(address_pool_key, 'b'*34)

      expect {
        service.call
      }.to change { $redis.llen(address_pool_key) }.from(2).to(1)
      expect(user.address).to eq('b'*34)
      expect(service.error).to be_blank
    end
  end

  context '#address_pool_key' do
    it 'equal to "address_pool"' do
      expect(address_pool_key).to eq('address_pool')
    end
  end
end
