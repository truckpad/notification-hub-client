FactoryGirl.define do
  factory :notification_hub_push_notification, class: 'Hash' do
    title 'Test 2'
    body 'Body of message'
    link 'truckpad://test'
    device_token '1234'
  end
end
