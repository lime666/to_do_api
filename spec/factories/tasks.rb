# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { FFaker::Book.title }
    description { FFaker::Book.description }
    status { 'New' }

    project

    trait :new_made do
      status { 'New' }
    end

    trait :in_progress do
      status { 'In Progress' }
    end

    trait :done do
      status { 'Done' }
    end
  end
end
