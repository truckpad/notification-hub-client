module NotificationHub
  class Notification
    class UnknowStrategyError < StandardError; end

    module Strategy
      Fallback = 0
      Multichannel = 1
    end

    attr_reader :messages
    attr_reader :options

    def initialize(messages: [], options: {})
      @messages = messages
      @options = options
    end

    def append(message)
      messages.push(message) if message.present?
    end

    def notify(strategy: Strategy::Fallback)
      if strategy == Strategy::Fallback
        send_notification(Envelope::Fallback.new(messages: messages, options: options).build)
      elsif strategy == Strategy::Multichannel
        send_notification(Envelope::Multichannel.new(messages: messages, options: options).build)
      else
        raise UnknowStrategyError.new("Unknow strategy: #{strategy}")
      end
    end

    private

    def send_notification(envelope)
      Channels::Sqs.new(envelope).send
    end
  end
end
