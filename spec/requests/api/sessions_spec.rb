require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  context 'POST /api/login' do
    let!(:user) { create(:user) }

    it 'successfully sign in and return token' do
      post '/api/login', headers: {'Authorization' => encode_credentials('bob@example.com', '123456')}

      expect(response.status).to eq(200)
      json = JSON.load(response.body)
      expect(json['auth_token']).to_not be_empty
    end

    it 'failed to sign in with wrong password' do
      post '/api/login', headers: {'Authorization' => encode_credentials('bob@example.com', '12345')}

      expect(response.status).to eq(401)
      json = JSON.load(response.body)
      expect(json['error']).to eq("Access denied!. Invalid credentials")
    end
  end
end
