# frozen_string_literal: true

FactoryBot.define do
  factory :exam do
    college
    name { 'Final' }
  end
end

