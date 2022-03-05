require 'rails_helper'

describe 'GET /api/v1/seed_catalogs' do
  let(:user) { create(:user) }
  before { create_list(:seed_catalog, 5, user: user) }

  context 'as an authenticated user' do
    before { sign_in(user) }
    before { get api_v1_seed_catalogs_path, headers: @auth_headers }

    context 'with no filters' do
      it 'returns a list of seed catalogs' do
        seed_catalogs = JSON.parse(response.body)

        expect(seed_catalogs.length).to eq 5

        seed_catalog = seed_catalogs[0]
        expect(seed_catalog['id']).to eq 1
        expect(seed_catalog['name']).to eq 'San Marzano Tomato'
        expect(seed_catalog['planting_date']).to eq '1 to 2 weeks before'
        expect(seed_catalog['planted']).to be false
      end

      it 'responds with a 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with filters' do
      let(:seed) { create(:seed, name: 'Super Max Hybrid Pickling Cucumber') }
      let(:other_seed) { create(:seed, name: 'Straight Eight Slicing Cucumber Seed') }
      before { create(:seed_catalog, seed: seed, user: user) }
      before { create(:seed_catalog, seed: other_seed, user: user) }
    
      it 'should fuzzy search by seed name' do
        get api_v1_seed_catalogs_path + '?name=cucumber', headers: @auth_headers

        data = JSON.parse(response.body)

        expect(data.count).to eq 2
      end
    end
  end

  context 'as a visitor' do
    before { get api_v1_seed_catalogs_path }

    it 'should return a serialized error' do
      data = JSON.parse(response.body)
      expect(data['errors']).to eq('Please log in.')
    end

    it 'should return a 401 status' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end