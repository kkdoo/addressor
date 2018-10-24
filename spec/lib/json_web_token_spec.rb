require 'rails_helper'

RSpec.describe JsonWebToken, type: :lib do
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  it 'successfully encode & decode' do
    encoded = JsonWebToken.encode(user_id: 1)
    decoded = JsonWebToken.decode(encoded)

    expect(decoded['user_id']).to eq(1)
    expect(decoded['exp']).to_not be_blank
  end
end

