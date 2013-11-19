# -*- encoding : utf-8 -*-
include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :product do
    sequence(:name) { |n| "Product ##{n}" }
    description "This is description text"
    price { rand }
    store
  end
  factory :deal do
    sequence(:name) { |n| "Deal ##{n}" }
    description "This is description text"
    slots { rand(1000).to_i }
    discount { rand(99).to_i + 1 }
    starts_at { Date.today }
    ends_at { Date.tomorrow }
    store
  end
  factory :news do
    sequence(:title) { |n| "This is #{n}" }
    content "Test content"
    store
  end
  factory :address do
    street_number { rand(100).to_i.to_s }
    street_name "Test street"
    postal_code 75101
    city "Paris"
    store
  end
  factory :picture do
    image { fixture_file_upload Rails.root.join('spec/fixtures/image.png'), 'image/png' }
    decorated { build :news }
    store
  end
  factory :store do
    sequence(:name) { |n| "Store ##{n}" }
    phone "1234567890"
    description "This is a description"
    logo { fixture_file_upload Rails.root.join('spec/fixtures/image.png'), 'image/png' }
    user { build :user, role: 'store_owner' }
    category
  end
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    role "user"
    sequence(:password) { |n| "testpass#{n}" }
    password_confirmation { |u| u.password }
  end
  factory :store_owner, parent: :user do
    role "store_owner"
    store
  end
  factory :category do
    sequence(:title) { |n| "test title ##{n}" }
    sequence(:permalink) { |n| "test_link#{n}" }
    description "gwhgwfjhwefgjhwef"
  end
  factory :schedule_item do
    effective_day ScheduleItem.ABBREVIATED_WEEKDAYS[0]
    discontinue_day ScheduleItem.ABBREVIATED_WEEKDAYS[4]
    start_at 10.hours
    end_at 17.hours
    store
  end
end
