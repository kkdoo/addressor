require 'rails_helper'

RSpec.describe User, type: :model do
  it 'valid factory' do
    expect(create(:user)).to be_valid
  end

  context '#address' do
    let(:user) { build(:user) }

    it 'no checks on nil, but should be checked on blank' do
      user.address = nil
      expect(user).to be_valid
      user.address = ' '
      expect(user).to_not be_valid
    end

    it 'should be in right format' do
      user.address = 'a'*34
      expect(user).to be_valid
      ['0', '.', 'O', 'I', 'i'].each do |char|
        user.address[20] = char
        expect(user).to_not be_valid
      end
    end

    it 'should have length in 34 charcters' do
      user.address = 'a'*33
      expect(user).to_not be_valid
      user.address = 'a'*35
      expect(user).to_not be_valid
      user.address = 'a'*34
      expect(user).to be_valid
    end
  end
end
