require 'rails_helper'

describe 'POST /api/v1/login' do
  let(:user) { create(:user, password: 'testpass123') }
  let(:valid_credentials) {{
    user: {
      email: user.email,
      password: 'testpass123'
    }
  }}
  let(:invalid_credentials) {{
    user: {
      email: 'bad@email.com',
      password: 'badpass'
    }
  }}

  context 'with valid credentials' do
    before { post user_session_path, params: valid_credentials }

    it 'should return a JWT token' do
      data = JSON.parse(response.body)
      jwt_payload = JWT.decode(data['token'], Rails.application.credentials.secret_key_base).first
      expect(jwt_payload['id']).to eq user.id
    end

    it 'should return a User' do
      data = JSON.parse(response.body)

      expect(data['id'])
      expect(data['email'])
      expect(data['nickname'])
      expect(data['zipcode'])
      expect(data['zone'])
      expect(data['last_frost'])
      expect(data['last_frost_short'])
    end
  end

  context 'with invalid credentials' do
    before { post user_session_path, params: invalid_credentials }

    it 'should return a 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end