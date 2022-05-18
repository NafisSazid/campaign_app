require 'rails_helper'

RSpec.describe Api::V1::CampaignsController, type: :controller do
  let!(:campaign) { FactoryBot.create(:campaign) }

  def formatted_time(t)
    t.strftime("%FT%T.%LZ")
  end

  describe 'GET #index' do
    context 'json responses' do
      it 'returns all campaigns' do
        get :index, params: { format: :json }

        expect(JSON.parse(response.body)).to eq(
          [
            {
              "id" => campaign.id,
              "name" => campaign.name,
              "country" => campaign.country,
              "image" => campaign.image,
              "investment_multiple" => campaign.investment_multiple.to_s,
              "percentage_raised" => campaign.percentage_raised.to_s,
              "sector" => campaign.sector,
              "target_amount" => campaign.target_amount.to_s,
              "created_at" => formatted_time(campaign.created_at),
              "updated_at" => formatted_time(campaign.updated_at),
            },
          ]
        )
      end
    end

    context 'with filter params' do
      let!(:campaign_2) { FactoryBot.create(:campaign, sector: 'Health') }

      it 'returns only filtered campaigns' do
        get :index, params: { sector: 'Health', format: :json }

        expect(JSON.parse(response.body)).to eq(
          [
            {
              "id" => campaign_2.id,
              "name" => campaign_2.name,
              "country" => campaign_2.country,
              "image" => campaign_2.image,
              "investment_multiple" => campaign_2.investment_multiple.to_s,
              "percentage_raised" => campaign_2.percentage_raised.to_s,
              "sector" => campaign_2.sector,
              "target_amount" => campaign_2.target_amount.to_s,
              "created_at" => formatted_time(campaign_2.created_at),
              "updated_at" => formatted_time(campaign_2.updated_at),
            },
          ]
        )
      end
    end
  end
end
