require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
  end

  context 'relationships' do
    it { should have_one :hardiness_zone }
    it { should have_many :seed_catalogs }
    it { should have_many :seeds }
  end
end
