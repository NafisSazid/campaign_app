class Investment < ApplicationRecord
  belongs_to :campaign
  
  validates :amount, presence: true, numericality: true
  validates :investor_name, :campaign, presence: true
  validate :validate_amount_with_investment_multiple
  validate :investment_allowed_check

  def validate_amount_with_investment_multiple
    return unless amount && campaign
    
    minimum_investment = campaign.investment_multiple
    return if amount % minimum_investment == 0
    
    quotient = amount / minimum_investment
    if quotient < 1
      errors.add(:amount, "Amount must be at least #{minimum_investment} GBP")
    else
      option_one = minimum_investment * (quotient.ceil(0) - 1)
      option_two = minimum_investment * quotient.ceil(0)
      errors.add(:amount, "Amount should be multiple of #{minimum_investment} GBP, eg.: #{option_one} or #{option_two} GBP")
    end
  end

  def investment_allowed_check
    return unless campaign

    if campaign.percentage_raised >= 100
      errors.add(:base, 'This campaign is full, you can try investing on other campaigns')
    end
  end
end
