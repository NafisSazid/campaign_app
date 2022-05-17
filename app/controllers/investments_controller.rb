class InvestmentsController < ApplicationController
  def create
    investment = Investment.new(investment_params)
    if investment.save
      render json: { status: 'SUCCESS', data: investment }, status: :created
      UpdateCampaignPercentageRaised.call(investment.campaign)
    else
      render json: { status: 'ERROR', data: investment.errors }, status: :unprocessable_entity
    end
  end

  private

  def investment_params
    params.permit(:investor_name, :amount, :campaign_id)
  end
end
