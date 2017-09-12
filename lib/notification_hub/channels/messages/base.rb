module NotificationHub
  module Channels
    module Messages
      class Base
        attr_reader :body

        def initialize(body)
          @body = body
        end

        def to_hash
          Hash[
            channel: channel,
            body: body
          ]
        end

        def channel
          raise NotImplementedError, 'Method \'channel\' must be implemented on subclasses'
        end
      end
    end
  end
end
