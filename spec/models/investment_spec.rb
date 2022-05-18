require 'rails_helper'

RSpec.describe Investment, type: :model do
  let(:campaign_instance) { FactoryBot.create(:campaign) }

  it { is_expected.to belong_to(:campaign) }

  describe 'validations' do
    it { should validate_presence_of(:amount) }
    it { should validate_presence_of(:investor_name) }
    it { should validate_numericality_of(:amount) }
  end

  describe 'validate_amount_with_investment_multiple' do
    let(:investment) { FactoryBot.create(:investment, campaign: campaign_instance) }

    it 'should not save invalid amount' do
      investment.update(amount: 30.0)
      expect(investment.errors.messages[:amount]).
        to eq(['Amount should be multiple of 20.5 GBP, eg.: 20.5 or 41.0 GBP'])
    end
  end
end
