module NotificationHub
  module Channels
    module Messages
      class PushNotification < Base
        attr_reader :title
        attr_reader :link
        attr_reader :device_token

        def initialize(device_token:, title:, link:, body:)
          super(body)
          @device_token = device_token
          @title = title
          @link = link
        end

        def to_hash
          super.to_hash.merge(Hash[title: title, device_token: device_token, link: link])
        end

        def channel
          'push-notification'
        end
      end
    end
  end
end
