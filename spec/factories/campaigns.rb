FactoryBot.define do
  factory :campaign do
    name { 'Test campaign' }
    image { 'image/url' }
    percentage_raised { 0.0 }
    target_amount { 400.0 }
    sector { 'Agro' }
    country { 'Sweden' }
    investment_multiple { 20.5 }
  end
end
