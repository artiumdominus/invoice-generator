# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create(email: "some.user@email.com")
token = Token.create(
  user:,
  active: true,
  activated_at: DateTime.current,
  last_login: DateTime.current
)

customers = ['Void Corp Inc.', 'Metatron HyperSystems', 'UwU Tek']
emails = [
  [
    "daenerys@voidcorp.com",
    "frodo@voidcorp.com",
    "lancelot@voidcorp.com"
  ],
  [
    "arthur@metaron.com",
    "culhwch@metatron.com",
    "adelma@metatron.com",
    "walganus@metatron.com"
  ],
  [
    "faust@uwutek.com",
    "launce@uwutek.com",
    "cai@uwutek.com"
  ]
]

(1..10).each do |n|
  Invoice.create(
    number: n,
    date: DateTime.current - (10 - n).day,
    customer_name: customers[n % 3],
    total_amount_due_cents: rand(10_000_00..20_000_00),
    emails: emails[n % 3],
    user: user
  )
end
