require 'spec_helper'

RSpec.describe NotificationHub::Notification do
  let(:sqs) { double(NotificationHub::Channels::Sqs) }

  let(:sms) { attributes_for(:notification_hub_sms) }
  let(:push_notification) { attributes_for(:notification_hub_push_notification) }
  let(:messages) { [sms, push_notification] }
  let(:options) do
    Hash[
      expires_in: 1.day.from_now,
      receiver_id: 1910,
      receiver_type: 'Driver',
      reason_id: 2012,
      reason_type: 'Shipment'
    ]
  end

  subject { NotificationHub::Notification.new(messages: messages, options: options) }

  describe '#initialize' do
    context 'when messages is not blank' do
      it { expect(subject.messages).to eq(messages) }
      it { expect(subject.options).to eq(options) }
    end
  end

  describe '#append' do
    context 'when message is present' do
      subject { NotificationHub::Notification.new(options: options) }
      it { expect{ subject.append(sms) }.to change{ subject.messages.size }.from(0).to(1) }
    end

    context 'when message is not present' do
      subject { NotificationHub::Notification.new(options: options) }
      it { expect{ subject.append(nil) }.not_to change{ subject.messages.size } }
    end
  end

  describe '#notify' do
    before do
      allow(NotificationHub::Channels::Sqs).to receive(:new).with(anything).and_return(sqs)
    end

    context 'when strategy is fallback' do
      it 'call the send method of sqs channel' do
        expect(sqs).to receive(:send)
        subject.notify(strategy: NotificationHub::Notification::Strategy::Fallback)
      end
    end

    context 'when strategy is multichannel' do
      it 'call the send method of sqs channel' do
        expect(sqs).to receive(:send)
        subject.notify(strategy: NotificationHub::Notification::Strategy::Multichannel)
      end
    end

    context 'when strategy is invalid' do
      it 'raise error' do
        expect{ subject.notify(strategy: -1) }.to raise_error(NotificationHub::Notification::UnknowStrategyError)
      end
    end
  end
end
