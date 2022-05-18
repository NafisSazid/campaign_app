module Api
  module V1
    class CampaignsController < ApplicationController
      def index
        campaigns = filter_list(Campaign.all)
        render json: campaigns, status: :ok
      end

      private

      def filter_list(campaigns)
        if params[:sector].present?
          campaigns = campaigns.where(sector: params[:sector])
        end
        if params[:amount].present?
          campaigns = campaigns.where("target_amount >= ?", params[:amount])
        end
        if params[:investor_number].present?
          campaigns = campaigns.joins(:investments).group("campaigns.id").
            having("COUNT(investments.id) = #{params[:investor_number]}")
        end

        campaigns
      end
    end
  end
end
