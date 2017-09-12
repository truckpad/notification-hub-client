require 'aws-sdk'

module NotificationHub
  module Channels
    class Sqs
      attr_reader :envelope

      QUEUE_URL = "#{ENV['AWS_SQS_URL']}#{ENV['NOTIFICATION_DISPATCHER_QUEUE']}".freeze

      DEFAULT_MESSAGE_BODY_HASH = {
        priority: nil,
        default_locale: 'en',
        job_class: 'NotificationHubJob'
      }.freeze

      def initialize(envelope)
        @envelope = envelope
      end

      def send
        client.send_message(message)
      end

      private

      def client
        @client ||= AWS.sqs(
          access_key_id: ENV['AWS_ACCESS_KEY_ID'],
          secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
          region: ENV['AWS_REGION']
        ).client
      end

      def message
        Hash[
          queue_url: QUEUE_URL,
          message_body: message_body,
          message_attributes: message_attributes
        ]
      end

      def message_body
        DEFAULT_MESSAGE_BODY_HASH.merge(
          job_id: SecureRandom.uuid,
          arguments: [envelope.to_json],
          queue_name: ENV['NOTIFICATION_DISPATCHER_QUEUE']
        ).to_json
      end

      def message_attributes
        Hash[
          'shoryuken_class' => Hash[
            data_type: 'String',
            string_value: 'ActiveJob::QueueAdapters::ShoryukenAdapter::JobWrapper'
          ]
        ]
      end
    end
  end
end
