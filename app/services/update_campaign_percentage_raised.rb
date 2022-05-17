class UpdateCampaignPercentageRaised
  attr_reader :campaign

  def self.call(campaign)
    new(campaign).call
  end

  def initialize(campaign)
    @campaign = campaign
  end

  def call
    target_amount = campaign.target_amount
    total_invested_amount = campaign.investments.map(&:amount).inject(0, &:+)
    percentage = (total_invested_amount / target_amount) * 100

    campaign.update!(percentage_raised: percentage)
  end
end