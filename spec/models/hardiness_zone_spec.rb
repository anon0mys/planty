require 'rails_helper'

RSpec.describe HardinessZone, type: :model do
  context 'validations' do
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :zone }
    it { should validate_presence_of :trange }
    it { should validate_presence_of :zonetitle }
  end
end
