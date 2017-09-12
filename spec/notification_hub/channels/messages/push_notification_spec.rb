require 'spec_helper'

RSpec.describe NotificationHub::Channels::Messages::PushNotification do
  let(:title) { 'Test title' }
  let(:link) { 'truckpad://test' }
  let(:device_token) { '912345' }
  let(:body) { 'Test body' }

  subject do
    NotificationHub::Channels::Messages::PushNotification.new(
      device_token: device_token,
      title: title,
      link: link,
      body: body
    )
  end

  describe '#initialize' do
    it { expect(subject.device_token).to eq(device_token) }
    it { expect(subject.title).to eq(title) }
    it { expect(subject.link).to eq(link) }
    it { expect(subject.body).to eq(body) }
  end

  describe '#to_hash' do
    let(:expected) do
      Hash[
        channel: 'push-notification',
        body: body,
        title: title,
        device_token: device_token,
        link: link
      ]
    end

    it { expect(subject.to_hash).to eq(expected) }
  end
end
