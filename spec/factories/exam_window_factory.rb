# frozen_string_literal: true

FactoryBot.define do
  factory :exam_window do
    exam
    starts_at { 1.day.ago }
    ends_at { 1.day.since }
  end
end


