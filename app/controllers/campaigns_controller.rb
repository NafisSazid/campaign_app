class CampaignsController < ApplicationController
  def index
    render json: Campaign.all, status: :ok
  end
end
