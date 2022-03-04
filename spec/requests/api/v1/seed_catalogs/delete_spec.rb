require 'rails_helper'

describe 'DELETE /api/v1/seed_catalogs/:id' do
  let(:user) { create(:user) }
  let(:catalog) { create(:seed_catalog, user: user) }

  context 'as an authenticated user' do
    before { sign_in(user) }
    before { delete api_v1_seed_catalog_path(catalog.id), headers: @auth_headers }

    it 'deletes a seed catalog' do
      data = JSON.parse(response.body)

      expect(data['message']).to eq "#{catalog.seed.name} has been removed from your catalog"
    end

    it 'responds with a 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'as a visitor' do
    before { delete api_v1_seed_catalog_path(catalog.id) }

    it 'should return a serialized error' do
      data = JSON.parse(response.body)
      expect(data['errors']).to eq('Please log in.')
    end

    it 'should return a 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end