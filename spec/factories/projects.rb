# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { FFaker::Book.title }
    description { FFaker::Book.description }

    user
  end
end
