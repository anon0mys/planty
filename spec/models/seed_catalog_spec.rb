require 'rails_helper'

RSpec.describe SeedCatalog, type: :model do
  context 'relationships' do
    it { should belong_to :user }
    it { should belong_to :seed }
  end
end
