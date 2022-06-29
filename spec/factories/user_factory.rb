# frozen_string_literal: true

# brute force a decent phone number for specs - Faker can generate garbage numbers
def valid_phone_number
  attempts = 0
  phone_number = ''

  loop do
    phone_number = Faker::PhoneNumber.phone_number
    attempts += 1
    raise "Cannot generate a possible phone number" if attempts > 100
    break if Phonelib.valid?(phone_number)
  end

  phone_number
end

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { valid_phone_number }
  end
end

