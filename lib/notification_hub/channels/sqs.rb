require 'aws-sdk'

module NotificationHub
  module Channels
    class Sqs
      attr_reader :envelope

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
          access_key_id: NotificationHub.configuration.aws_access_key_id,
          secret_access_key: NotificationHub.configuration.aws_secret_access_key,
          region: NotificationHub.configuration.aws_region
        ).client
      end

      def message
        Hash[
          queue_url: Sqs.queue_url,
          message_body: message_body,
          message_attributes: message_attributes
        ]
      end

      def message_body
        DEFAULT_MESSAGE_BODY_HASH.merge(
          job_id: SecureRandom.uuid,
          arguments: [envelope.to_json],
          queue_name: NotificationHub.configuration.notification_dispatcher_queue
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

      def self.queue_url
        $queue_url ||= "#{NotificationHub.configuration.aws_sqs_url}"\
                       "#{NotificationHub.configuration.notification_dispatcher_queue}"
      end
    end
  end
end
