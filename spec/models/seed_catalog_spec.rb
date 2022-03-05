require 'rails_helper'

RSpec.describe SeedCatalog, type: :model do
  context 'relationships' do
    it { should belong_to :user }
    it { should belong_to :seed }
  end

  context 'scopes' do
    before { create_list(:seed_catalog, 5) }

    it 'should filter by seed name' do
      seed = create(:seed, name: 'Searchable')
      create(:seed_catalog, seed: seed)

      expect(Seed.name_eq('searchable').count).to eq 1
    end
  end
end
