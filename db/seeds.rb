# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

30.times do
  Campaign.create(
    {
      name: Faker::Name.name,
      image: Faker::Avatar.image,
      percentage_raised: 0,
      target_amount: Faker::Number.number(digits: 3),
      sector: Faker::Commerce.department(max: 1),
      country: Faker::Address.country,
      investment_multiple: Faker::Number.between(from: 10.0, to: 50.0).round(2),
    }
  )
end
