require 'spec_helper'

RSpec.describe NotificationHub::Channels::Messages::Sms do
  let(:phone_number) { '5511987878787' }
  let(:body) { 'Test body' }

  subject do
    NotificationHub::Channels::Messages::Sms.new(
      phone_number: phone_number,
      body: body
    )
  end

  describe '#initialize' do
    it { expect(subject.phone_number).to eq(phone_number) }
    it { expect(subject.body).to eq(body) }
  end

  describe '#to_hash' do
    let(:expected) do
      Hash[
        channel: 'sms',
        body: body,
        phone_number: phone_number
      ]
    end

    it { expect(subject.to_hash).to eq(expected) }
  end
end
