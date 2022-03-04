require 'rails_helper'

describe 'PATCH /api/v1/seed_catalogs/:id' do
  let(:user) { create(:user) }
  let(:catalog) { create(:seed_catalog, user: user, planted: false) }
  let(:valid_attrs) {{
    seed_catalog: {
      planted: true
    }
  }}

  context 'as an authenticated user' do
    before { sign_in(user) }
    before { patch api_v1_seed_catalog_path(catalog.id), headers: @auth_headers, params: valid_attrs }

    it 'updates a seed catalog' do
      seed_catalog = JSON.parse(response.body)

      expect(seed_catalog['planted']).to be true
    end

    it 'responds with a 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'as a visitor' do
    before { patch api_v1_seed_catalog_path(catalog.id), params: valid_attrs }

    it 'should return a serialized error' do
      data = JSON.parse(response.body)
      expect(data['errors']).to eq('Please log in.')
    end

    it 'should return a 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end