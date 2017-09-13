require 'active_support/all'
require 'notification_hub/configuration'
require 'notification_hub/notification'
require 'notification_hub/channels/sqs'
require 'notification_hub/channels/messages/base'
require 'notification_hub/channels/messages/push_notification'
require 'notification_hub/channels/messages/sms'
require 'notification_hub/envelope/base'
require 'notification_hub/envelope/fallback'
require 'notification_hub/envelope/multichannel'

module NotificationHub
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= NotificationHub::Configuration.new
  end

  def self.reset
    @configuration = NotificationHub::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
