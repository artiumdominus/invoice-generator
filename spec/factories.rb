FactoryBot.define do
  factory(:user) { email { Faker::Internet.email } }

  factory(:token) do
    user

    trait :active do
      active { true }
    end
  end

  factory :invoice do
    sequence(:number)

    transient do
      street_address { Faker::Address.street_address }
      city { Faker::Address.city }
      zip { Faker::Address.zip }
      duns_number { Faker::Company.duns_number }
    end

    date { Date.current }
    customer_name { Faker::Company.name }
    customer_notes do
      <<-NOTES
        address: #{street_address} - #{city}
        zip: #{zip}
        phone: #{duns_number}
      NOTES
    end
    total_amount_due_cents { rand(18_000_00..22_000_00) }
    emails { (1..3).map { Faker::Internet.email } }

    user
  end
end
