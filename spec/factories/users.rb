# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'email@example.com' }
    password { 'My@String12' }
  end
end
