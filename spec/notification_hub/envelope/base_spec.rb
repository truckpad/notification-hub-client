require 'spec_helper'

RSpec.describe NotificationHub::Envelope::Base do
  let(:sms) { attributes_for(:notification_hub_sms) }
  let(:push_notification) { attributes_for(:notification_hub_push_notification) }
  let(:messages) { [sms, push_notification] }
  let(:expires_in) { 1.day.from_now }
  let(:receiver_id) { 1910 }
  let(:receiver_type) { 'Driver' }
  let(:reason_id) { 2012 }
  let(:reason_type) { 'Shipment' }

  let(:options) do
    Hash[
      expires_in: expires_in,
      receiver_id: receiver_id,
      receiver_type: receiver_type,
      reason_id: reason_id,
      reason_type: reason_type
    ]
  end

  subject { NotificationHub::Envelope::Base.new(messages: messages, options: options) }

  describe '#initialize' do
    it { expect(subject.messages).to eq(messages) }
    it { expect(subject.expires_in).to eq(expires_in) }
    it { expect(subject.receiver_id).to eq(receiver_id) }
    it { expect(subject.receiver_type).to eq(receiver_type) }
    it { expect(subject.reason_id).to eq(reason_id) }
    it { expect(subject.reason_type).to eq(reason_type) }
  end

  describe '#build' do
    class NotificationHub::Envelope::Test < NotificationHub::Envelope::Base
      def strategy
        'test'
      end
    end

    subject { NotificationHub::Envelope::Test.new(messages: messages, options: options) }

    context 'when messages are present' do
      let(:expected) do
        Hash[
          strategy: 'test',
          expires_in: expires_in,
          receiver_id: receiver_id,
          receiver_type: receiver_type,
          reason_id: reason_id,
          reason_type: reason_type,
          messages: messages
        ]
      end

      it { expect(subject.build).to eq(expected) }
    end
  end
end
