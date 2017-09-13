module NotificationHub
  class Configuration
    attr_accessor :notification_dispatcher_queue
    attr_accessor :aws_sqs_url
    attr_accessor :aws_access_key_id
    attr_accessor :aws_secret_access_key
    attr_accessor :aws_region

    def initialize
      @notification_dispatcher_queue=nil
      @aws_sqs_url=nil
      @aws_access_key_id=nil
      @aws_secret_access_key=nil
      @aws_region=nil
    end
  end
end
