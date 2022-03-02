require 'rails_helper'

RSpec.describe HardinessZone, type: :model do
  context 'validations' do
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :zone }
    it { should validate_presence_of :trange }
    it { should validate_presence_of :zonetitle }
  end

  context 'filters' do
    before { create(:hardiness_zone, zipcode: '80017') }
    before { create(:hardiness_zone, zipcode: '80212') }

    it 'it should find by zipcode' do
      expect(HardinessZone.zipcode_eq('80017')).to eq HardinessZone.first
    end
  end
end
