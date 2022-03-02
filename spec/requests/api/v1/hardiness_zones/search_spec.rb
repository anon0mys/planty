require 'rails_helper'

describe 'GET /api/v1/hardiness_zones/search' do
  before { create(:hardiness_zone, zipcode: '80017', zone: '5a') }
  before { create(:hardiness_zone, zipcode: '90210', zone: '6a') }
  before { create(:hardiness_zone, zipcode: '87513', zone: '6b') }

  context 'with valid search params' do
    it 'should search by zipcode' do
      get search_api_v1_hardiness_zones_path + '?zipcode=80017'

      zone = JSON.parse(response.body)

      expect(zone['zipcode']).to eq('80017')
      expect(zone['zone']).to eq('5a')
      expect(zone['trange']).to eq('-15 to -10')
      expect(zone['zonetitle']).to eq('5b: -15 to -10')
    end
  end

  context 'without search params' do
    before { get search_api_v1_hardiness_zones_path }

    it 'should return errors describing required params' do
      data = JSON.parse(response.body)
      expect(data['errors']).to eq 'Hardiness Zone search requires zipcode or city, state'
    end

    it 'should respond with 400 bad request' do
      expect(response).to have_http_status :bad_request
    end
  end
end