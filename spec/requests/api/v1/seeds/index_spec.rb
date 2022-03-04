require 'rails_helper'

describe 'GET /api/v1/seeds' do
  context 'with no filter' do
    before { create_list(:seed, 3) }
    before { get api_v1_seeds_path }

    it 'should return a list of seeds' do
      data = JSON.parse(response.body)
      expect(data.count).to eq 3
    end

    it 'should serialize the seeds' do
      data = JSON.parse(response.body)
      seed = data[0]

      expect(seed['botanical_name']).to eq("Lycopersicon lycopersicum 'San Marzano'")
      expect(seed['height']).to eq("4 feet. Indeterminate. ")
      expect(seed['spacing']).to eq("18 - 24 inches between plants, 3 - 5 feet between rows.")
      expect(seed['depth']).to eq("Plant seeds 1/4 inch deep.")
      expect(seed['spread']).to eq("2 - 3 feet.")
      expect(seed['light_required']).to eq("Full Sun")
      expect(seed['pollinator']).to eq("Self pollinating.")
      expect(seed['yield']).to eq("Heavy yields.")
      expect(seed['color']).to eq("Green")
      expect(seed['size']).to eq("25 Seed Pkt")
      expect(seed['blooms']).to eq("April- May")
      expect(seed['fruit']).to eq("Elongated, red fruits, meaty and very flavorful.")
      expect(seed['days_to_maturity']).to eq("85 Days")
      expect(seed['zone']).to eq("3-9")
      expect(seed['germination']).to eq("7 - 10 Days")
      expect(seed['form']).to eq("Vegetable, Tomato, Heirloom Tomato, Indeterminate")
      expect(seed['flower_form']).to eq("Yellow flowers.")
      expect(seed['soil_requirements']).to eq("Well-drained, deep fertile soil.")
      expect(seed['growth_rate']).to eq("Moderate growth rate.")
      expect(seed['seed_count']).to eq("Approximately 25 seeds per packet.")
      expect(seed['pruning']).to eq("Fruit ripens earlier since the sun can reach it more easily.")
      expect(seed['foliage']).to eq("Green foliage.")
      expect(seed['name']).to eq("San Marzano Tomato")
      expect(seed['category']).to eq("open_pollinated_tomatoes")
    end
  end

  context 'with filters' do
    before { create_list(:seed, 3) }
    before { create(:seed, name: 'Super Max Hybrid Pickling Cucumber') }
    before { create(:seed, name: 'Straight Eight Slicing Cucumber Seed') }

    it 'should fuzzy search by name' do
      get api_v1_seeds_path + '?name=cucumber'
      data = JSON.parse(response.body)

      expect(data.count).to eq 2
    end
  end
end