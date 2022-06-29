# frozen_string_literal: true

FactoryBot.define do
  factory :user_exam do
    user
    exam
    starts_at { Time.current }
  end
end
