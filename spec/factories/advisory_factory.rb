# frozen_string_literal: true

FactoryBot.define do
  factory :advisory do
    sequence(:identifier) { |n| "activerecord-CVE-2019-567#{n}" }
  end
end
