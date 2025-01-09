# db/seeds.rb

require 'city-state'

# Clear existing data
Account.destroy_all
Business.destroy_all
Customer.destroy_all
Profile.destroy_all

# Helper method to generate Nigerian phone numbers
def nigerian_phone_number
  "+234#{rand(7000000000..8099999999)}"
end

# Helper method to generate international phone numbers
def international_phone_number
  "+#{rand(1..999)}#{rand(100000000..999999999)}"
end

# Helper method to generate Nigerian addresses
def nigerian_address
  state = CS.states(:NG).keys.sample
  city = CS.cities(state, :NG).sample
  "#{Faker::Address.street_address}, #{city}, #{state}, Nigeria"
end

# Helper method to generate international addresses
def international_address(country)
  "#{Faker::Address.street_address}, #{Faker::Address.city}, #{country}"
end

# Create the first account
account1 = Account.create!(
  email: 'tolase@sabimanager.com',
  password_hash: BCrypt::Password.create('foofoofoo'), # Use BCrypt to hash the password
  status: 2 # verified
)

# Update the profile for the first account
account1.create_profile!(
  name: 'Tolase Kelvin',
  country: 'Nigeria'
)

# Create businesses for the first account
business1_1 = account1.businesses.create!(
  name: 'Lashe Tech',
  description: 'Home for all tech gadgets',
  currency: 'US Dollar'
)

business1_2 = account1.businesses.create!(
  name: 'Arikeade Trendings',
  description: 'Unisex Fashion store',
  currency: 'Nigerian Naira'
)

business1_3 = account1.businesses.create!(
  name: 'Lashe Grills',
  description: 'Finger food',
  currency: 'Nigerian Naira'
)

# Create the second account
account2 = Account.create!(
  email: 'test@test.com',
  password_hash: BCrypt::Password.create('foofoofoo'), # Use BCrypt to hash the password
  status: 2 # verified
)

# Update the profile for the second account
account2.create_profile!(
  name: 'Test User',
  country: 'Nigeria'
)

# Create businesses for the second account
business2_1 = account2.businesses.create!(
  name: 'Styled by Simi',
  description: 'Unisex Fashion designer',
  currency: 'Nigerian Naira'
)

business2_2 = account2.businesses.create!(
  name: 'Lashe Cuts',
  description: 'Unisex hair salon',
  currency: 'US Dollar'
)

business2_3 = account2.businesses.create!(
  name: 'Scents by Rikky',
  description: 'Home for unisex perfume and sprays',
  currency: 'Nigerian Naira'
)

# Create 50 customers for each business
[business1_1, business1_2, business1_3, business2_1, business2_2, business2_3].each do |business|
  50.times do
    # Assign Nigeria to 70% of customers
    country = if rand <= 0.7
               'Nigeria'
             else
               CS.countries.values.sample
             end

    # Generate phone number based on country
    phone_number = if country == 'Nigeria'
                    nigerian_phone_number
                  else
                    international_phone_number
                  end

    # Generate address based on country
    address = if country == 'Nigeria'
               nigerian_address
             else
               international_address(country)
             end

    Customer.create!(
      name: Faker::Name.name,
      email: Faker::Internet.unique.email,
      phone_number: phone_number,
      business_id: business.id,
      account_id: business.account_id,
      country: country,
      address: address
    )
  end
end

puts "Seeded #{Account.count} accounts, #{Business.count} businesses, and #{Customer.count} customers."