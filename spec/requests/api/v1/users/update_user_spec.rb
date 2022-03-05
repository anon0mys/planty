require 'rails_helper'

describe 'PATCH /api/v1/users' do
  let(:user) { create(
    :user,
    email: 'old@email.com',
    nickname: 'Old'
  )}
  let(:valid_attrs) {{
    user: {
      email: 'test@email.com',
      nickname: 'Some Name',
      zipcode: '80017'
    }
  }}
  let(:invalid_zip) {{
    user: {
      zipcode: '99999'
    }
  }}
  let(:zone) {{
    zipcode: "80017",
    zone: "6a",
    trange: "-10 to -5",
    zonetitle: "6a: -10 to -5",
    last_frost: "04/28/2022",
    last_frost_short: "Apr 28"
  }}
  before { Rails.cache.redis.set('80017', zone.to_json) }
  before { sign_in(user) }

  context 'with valid attributes' do
    before { patch user_registration_path, headers: @auth_headers, params: valid_attrs }

    it 'should return a JWT token' do
      data = JSON.parse(response.body)
      jwt_payload = JWT.decode(data['token'], Rails.application.credentials.secret_key_base).first
      expect(jwt_payload['id']).to eq 1
    end

    it 'should return an updated User' do
      data = JSON.parse(response.body)

      expect(data['id'])
      expect(data['email']).to eq 'test@email.com'
      expect(data['nickname']).to eq 'Some Name'
      expect(data['zipcode']).to eq '80017'
      expect(data['zone']).to eq '6a'
      expect(data['last_frost']).to eq '04/28/2022'
      expect(data['last_frost_short']).to eq 'Apr 28'
    end
  end

  context 'with invalid zipcode' do
    before { patch user_registration_path, headers: @auth_headers, params: invalid_zip }

    it 'should return a 422 status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'as a visitor' do
    before { patch user_registration_path, params: valid_attrs }

    it 'should return a serialized error' do
      data = JSON.parse(response.body)
      expect(data['errors']).to eq('Please log in.')
    end

    it 'should return a 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end