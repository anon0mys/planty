require 'rails_helper'

RSpec.describe Seed, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :botanical_name }
    it { should validate_presence_of :category }
  end
end
