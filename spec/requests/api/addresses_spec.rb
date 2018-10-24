require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  context 'GET /api/my_address' do
    let!(:user) { create(:user, :with_address) }
    let(:token) { JsonWebToken.encode(user_id: user.id) }

    it 'successfully return user object' do
      get '/api/my_address', headers: {'Authorization' => encode_credentials(token, '')}

      expect(response.status).to eq(200)
      json = JSON.load(response.body)
      expect(json['id']).to eq(user.id)
      expect(json['address']).to eq(user.address)
    end

    it 'failed to response with wrong token' do
      get '/api/my_address', headers: {'Authorization' => encode_credentials('wrong_token', '')}

      expect(response.status).to eq(401)
      json = JSON.load(response.body)
      expect(json['error']).to eq("Access denied!. Invalid token supplied.")
    end
  end

  context 'POST /api/address' do
    let!(:user) { create(:user, :with_address) }
    let(:token) { JsonWebToken.encode(user_id: user.id) }

    it 'successfully update address from pool' do
      $redis.lpush('address_pool', 'a'*34)

      post '/api/addresses', headers: {'Authorization' => encode_credentials(token, '')}

      expect(response.status).to eq(200)
      json = JSON.load(response.body)
      expect(json['id']).to eq(user.id)
      expect(json['address']).to eq(user.address)
    end

    it 'should return messege if pool is empty' do
      post '/api/addresses', headers: {'Authorization' => encode_credentials(token, '')}

      expect(response.status).to eq(400)
      json = JSON.load(response.body)
      expect(json['error']).to match(/Address Pool empty, please try again in/)
    end

    it 'failed to response with wrong token' do
      post '/api/addresses', headers: {'Authorization' => encode_credentials('wrong_token', '')}

      expect(response.status).to eq(401)
      json = JSON.load(response.body)
      expect(json['error']).to eq("Access denied!. Invalid token supplied.")
    end
  end
end

