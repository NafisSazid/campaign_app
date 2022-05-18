require 'rails_helper'

RSpec.describe Campaign, type: :model do
  it { is_expected.to have_many(:investments) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:target_amount) }
    it { should validate_presence_of(:investment_multiple) }
    it { should validate_presence_of(:sector) }
    it { should validate_uniqueness_of(:name) }
  end

  describe '#total_invested_amount' do
    let(:campaign) { FactoryBot.create(:campaign) }
    let!(:investment_1) { FactoryBot.create(:investment, amount: 41, campaign: campaign) }
    let!(:investment_2) { FactoryBot.create(:investment, amount: 82, campaign: campaign) }

    it 'should return total invested amount' do
      total = 41 + 82
      expect(campaign.total_invested_amount).to eq(total)
    end
  end
end
