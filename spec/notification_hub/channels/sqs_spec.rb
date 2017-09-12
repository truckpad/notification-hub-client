require 'spec_helper'

RSpec.describe NotificationHub::Channels::Sqs do
  let(:uuid) {SecureRandom.uuid}

  let(:sms) { attributes_for(:notification_hub_sms) }
  let(:messages) { [sms] }
  let(:envelope) {NotificationHub::Envelope::Base.new(messages: messages, options: {})}

  let(:message_attributes) do
    Hash[
      'shoryuken_class' => Hash[
        data_type: 'String',
        string_value: 'ActiveJob::QueueAdapters::ShoryukenAdapter::JobWrapper'
      ]
    ]
  end

  let(:message_body) do
    Hash[
      priority: nil,
      default_locale: 'en',
      job_class: 'NotificationHubJob',
      job_id: SecureRandom.uuid,
      arguments: [envelope.to_json],
      queue_name: ENV['NOTIFICATION_DISPATCHER_QUEUE']
    ].to_json
  end

  let(:message) do
    Hash[
      queue_url: 'http://test',
      message_body: message_body,
      message_attributes: message_attributes
    ]
  end

  let(:sqs_client) { double(AWS::SQS::Client::V20121105) }
  let(:sqs) { double(AWS::SQS) }

  subject { NotificationHub::Channels::Sqs.new(envelope) }

  before do
    allow(SecureRandom).to receive(:uuid).and_return(uuid)
    allow(AWS).to receive(:sqs).
                  with(access_key_id: anything, secret_access_key: anything, region: anything).
                  and_return(sqs)
    allow(sqs).to receive(:client).and_return(sqs_client)
    stub_const('NotificationHub::Channels::Sqs::QUEUE_URL', 'http://test')
  end

  describe '#send' do
    it 'call the send method of sqs client'  do
      expect(sqs_client).to receive(:send_message).with(message)
      subject.send
    end
  end
end
