class Campaign < ApplicationRecord
  has_many :investments
  
  validates :name, :target_amount, :sector, :investment_multiple, presence: true
  validates_uniqueness_of :name

  def total_invested_amount
    investments.map(&:amount).inject(0, &:+)
  end
end
