FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
  end

  factory :token do
    user
  end

  factory :invoice do
    sequence(:number)

    date { Date.current }
    customer_name { Faker::Company.name }
    customer_notes do
      <<-NOTES
        address: #{Faker::Address.street_address} - #{Faker::Address.city}
        zip: #{Faker::Address.zip}
        phone: #{Faker::Company.duns_number}
      NOTES
    end
    total_amount_due_cents { rand(18_000_00..22_000_00) }
    emails { (1..3).map { Faker::Internet.email } }

    user
  end
end
