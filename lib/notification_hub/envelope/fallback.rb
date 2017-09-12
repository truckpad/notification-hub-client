module NotificationHub
  module Envelope
    class Fallback < Base
      def strategy
        'fallback'
      end
    end
  end
end
