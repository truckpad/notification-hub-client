module NotificationHub
  module Envelope
    class Multichannel < Base
      def strategy
        'multichannel'
      end
    end
  end
end
