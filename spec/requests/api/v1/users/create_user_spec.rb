require 'rails_helper'

describe 'POST /api/v1/users' do
  let(:valid_attrs) {{
    user: {
      email: 'test@email.com',
      nickname: 'Some Name',
      zipcode: '80017',
      password: 'testpass123',
      password_confirmation: 'testpass123'
    }
  }}
  let(:mismatched_password) {{
    user: {
      email: 'test@email.com',
      nickname: 'Some Name',
      zipcode: '80017',
      password: 'testpass123',
      password_confirmation: 'nomatch'
    }
  }}
  let(:invalid_zip) {{
    user: {
      email: 'test@email.com',
      nickname: 'Some Name',
      zipcode: '99999',
      password: 'testpass123',
      password_confirmation: 'nomatch'
    }
  }}
  let(:zone) {{
    zipcode: "80017",
    zone: "6a",
    trange: "-10 to -5",
    zonetitle: "6a: -10 to -5",
    last_frost: "Apr 28",
    last_frost_short: "04/28/2022"
  }}
  before { Rails.cache.redis.set('80017', zone.to_json) }

  context 'with valid credentials' do
    before { post user_registration_path, params: valid_attrs }

    it 'should return a JWT token' do
      data = JSON.parse(response.body)
      jwt_payload = JWT.decode(data['token'], Rails.application.credentials.secret_key_base).first
      expect(jwt_payload['id']).to eq 1
    end

    it 'should return a User' do
      data = JSON.parse(response.body)

      expect(data['id'])
      expect(data['email'])
      expect(data['zipcode'])
      expect(data['zone'])
      expect(data['last_frost'])
      expect(data['last_frost_short'])
    end
  end

  context 'with mismatched passwords' do
    before { post user_registration_path, params: mismatched_password }

    it 'should return a 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'with invalid zipcode' do
    before { post user_registration_path, params: invalid_zip }

    it 'should return a 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end