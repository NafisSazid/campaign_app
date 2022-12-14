require 'rails_helper'

RSpec.describe Api::V1::InvestmentsController, type: :controller do
  let(:campaign) { FactoryBot.create(:campaign) }

  def formatted_time(t)
    t.strftime("%FT%T.%LZ")
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) do
        {
          investor_name: 'Amit',
          amount: '20.5',
          campaign_id: campaign.id,
        }
      end

      it 'creates a new investment' do
        expect { post :create, params: valid_attributes }.to change(Investment, :count).by(1)
      end

      it 'format JSON' do
        post :create, params: valid_attributes.merge(format: :json)

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)).to eq(
          {
            "data" => {
              "id" => 1,
              "investor_name" => valid_attributes[:investor_name],
              "amount" => valid_attributes[:amount],
              "campaign_id" => campaign.id,
              "created_at" => formatted_time(Investment.last.created_at),
              "updated_at" => formatted_time(Investment.last.updated_at),
            },
            "status" => "SUCCESS"
          }
        )
      end

      it 'updates Campaign Percentage Raised after successfully save' do
        expect(UpdateCampaignPercentageRaised).to receive(:call).with(campaign)
        post :create, params: valid_attributes
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) do
        {
          investor_name: nil,
          amount: nil,
          campaign_id: campaign.id,
        }
      end

      it 'does not create an investment' do
        expect { post :create, params: invalid_attributes }.not_to change(Investment, :count)
      end

      it 'shows error messages' do
        post :create, params: invalid_attributes.merge(format: :json)

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)).to eq(
          {
            "data" => {
              "amount" => ["can't be blank", "is not a number"],
              "investor_name" => ["can't be blank"],
            },
            "status" => "ERROR"
          }
        )
      end
    end

    context 'when amount mismatches with investment_multiple' do
      it 'does not create and shows error message' do
        # here investment_multiple == 20.5
        post :create, params: { investor_name: 'Henry', amount: 31, campaign_id: campaign.id }

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['data']).to eq(
          {
            "amount" => ["Amount should be multiple of 20.5 GBP, eg.: 20.5 or 41.0 GBP"]
          }
        )
      end
    end
  end
end
