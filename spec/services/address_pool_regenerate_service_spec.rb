require 'rails_helper'

RSpec.describe AddressPoolRegenerateService, type: :service do
  let(:service) { described_class.new }
  let(:address_pool_key) { service.send(:address_pool_key) }

  context '#call' do
    it 'generates list with 10 addresses' do
      expect {
        service.call
      }.to change { $redis.llen(address_pool_key) }.from(0).to(AddressPoolRegenerateService::POOL_SIZE)
    end

    it 'clear existing addresses on the call' do
      $redis.lpush(address_pool_key, 'something')

      expect {
        service.call
      }.to change { $redis.llen(address_pool_key) }.from(1).to(AddressPoolRegenerateService::POOL_SIZE)
    end
  end

  context '#address_pool_key' do
    it 'equal to "address_pool"' do
      expect(address_pool_key).to eq('address_pool')
    end
  end

  context '#generate_address' do
    let(:result) { service.send(:generate_address) }

    it 'return 34 chars' do
      expect(result.length).to eq(AddressPoolRegenerateService::MAX_ADDRESS_SIZE)
    end

    it "not contains 'O', 'I', 'i' and '0' chars" do
      expect(result.chars & ['I', 'i', '0']).to be_empty
    end

    it 'regenerated every call' do
      expect(result).to_not eq(service.send(:generate_address))
    end
  end
end
