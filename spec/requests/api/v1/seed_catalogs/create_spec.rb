require 'rails_helper'

describe 'POST /api/v1/seed_catalogs' do
  let(:seed) { create(:seed) }
  let(:valid_attrs) {{
    seed_catalog: {
      seed_id: seed.id
    }
  }}
  let(:invalid_attrs) {{
    seed_catalog: {
      seed_id: 999
    }
  }}

  context 'as an authenticated user' do
    let(:user) { create(:user) }
    before { sign_in(user) }

    context 'with valid attributes' do
      before { post api_v1_seed_catalogs_path, headers: @auth_headers, params: valid_attrs}

      it 'creates a seed catalog' do
        seed_catalog = JSON.parse(response.body)
        expect(seed_catalog['id']).to eq 1
        expect(seed_catalog['name']).to eq seed.name
        expect(seed_catalog['planting_date']).to eq seed.planting_date
      end

      it 'responds with a 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid attrs' do
      before { post api_v1_seed_catalogs_path, headers: @auth_headers, params: invalid_attrs}

      it 'responds with an errors key' do
        data = JSON.parse(response.body)
        expect(data['errors']).to eq "Validation failed: Seed must exist"
      end

      it 'responds with a 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'as a visitor' do
    before { post api_v1_seed_catalogs_path, params: valid_attrs }

    it 'should return a serialized error' do
      data = JSON.parse(response.body)
      expect(data['errors']).to eq('Please log in.')
    end

    it 'should return a 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end