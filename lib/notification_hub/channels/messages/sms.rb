module NotificationHub
  module Channels
    module Messages
      class Sms < Base
        attr_reader :phone_number

        def initialize(phone_number:, body:)
          super(body)
          @phone_number = phone_number
        end

        def to_hash
          super.to_hash.merge(Hash[phone_number: phone_number])
        end

        def channel
          'sms'
        end
      end
    end
  end
end
