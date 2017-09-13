RSpec.configure do |config|
  config.before(:all) do
    NotificationHub.configure do |config|
      config.notification_dispatcher_queue = 'notification_dispatcher_queue'
      config.aws_sqs_url = 'http://test/'
      config.aws_access_key_id = 'aws_access_key_id'
      config.aws_secret_access_key = 'aws_secret_access_key'
      config.aws_region = 'aws_region'
    end
  end
end
