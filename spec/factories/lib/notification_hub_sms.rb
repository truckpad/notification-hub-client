FactoryGirl.define do
  factory :notification_hub_sms, class: 'Hash' do
    body 'Body of message'
    phone_number '5511891919191'
  end
end
