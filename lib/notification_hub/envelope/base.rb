module NotificationHub
  module Envelope
    class Base
      attr_reader :messages
      attr_reader :expires_in
      attr_reader :receiver_id
      attr_reader :receiver_type
      attr_reader :reason_id
      attr_reader :reason_type

      def initialize(messages:, options:)
        @messages = messages
        @expires_in = options[:expires_in] || 1.hour.from_now
        @receiver_id = options[:receiver_id]
        @receiver_type = options[:receiver_type]
        @reason_id = options[:reason_id]
        @reason_type = options[:reason_type]
      end

      def build
        Hash[
          strategy: strategy,
          expires_in: expires_in,
          receiver_id: receiver_id,
          receiver_type: receiver_type,
          reason_id: reason_id,
          reason_type: reason_type,
          messages: messages
        ]
      end

      def strategy
        raise NotImplementedError, 'Method \'strategy\' must be implemented on subclasses'
      end
    end
  end
end
