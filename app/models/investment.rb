class Investment < ApplicationRecord
  belongs_to :campaign
  
  validates :amount, presence: true, numericality: true
  validates :investor_name, presence: true
  validates :campaign, presence: true
  validate :validate_amount_with_investment_multiple

  # after_create :recalculate_campaign_percentage_raised
  
  
  def validate_amount_with_investment_multiple
    return unless amount
    
    minimum_investment = campaign.investment_multiple
    return if amount % minimum_investment == 0
    
    quotient = amount / minimum_investment
    if quotient < 1
      errors.add(:amount, "Amount must be at least #{minimum_investment} GBP")
    else
      option_one = minimum_investment * (quotient.ceil(0) -1)
      option_two = minimum_investment * quotient.ceil(0)
      errors.add(:amount, "Amount should be multiple of #{minimum_investment} GBP, eg.: #{option_one} or #{option_two} GBP")
    end
  end
end
