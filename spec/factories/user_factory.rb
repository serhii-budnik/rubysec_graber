# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email
    password { '12345678' }
    password_confirmation { password }

    before(:create, &:skip_confirmation!)
  end
end
