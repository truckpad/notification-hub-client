# NotificationHub Client

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'notification-hub-client', git: 'https://github.com/truckpad/notification-hub-client'
#OR
gem 'notification-hub-client', git: 'https://github.com/truckpad/notification-hub-client', require: 'notification_hub'
```

And then execute:

    $ bundle

## Setup

```ruby
# config/initializers/notification_hub_client.rb
require 'notification_hub'

NotificationHub.configure do |config|
  config.notification_dispatcher_queue = '[notification_dispatcher_queue]'
  config.aws_sqs_url = '[aws_sqs_url]'
  config.aws_access_key_id = '[aws_access_key_id]'
  config.aws_secret_access_key = '[aws_secret_access_key]'
  config.aws_region = '[aws_region]'
end
```

## Usage

Send Push Notification and SMS

```ruby
require 'notification_hub'

notification_hub = NotificationHub::Notification.new(
	options: {
		receiver_id: receiver.id,
		receiver_type: 'Receiver',
		reason_id: reason.id,
		reason_type: 'Reason'
	}
)

push_notification = NotificationHub::Channels::Messages::PushNotification.new(
	device_token: ['Receiver\'s Api-ID'],
    title: 'Title',
    link: 'Deep link',
    body: 'Message'
)

notification_hub.append(push_notification)

sms = NotificationHub::Channels::Messages::Sms.new(
	phone_number: '+55DDNNNNNNNNN',
    body: 'Message'
)

notification_hub.append(sms)

# Sends push notification and sms
notification_hub.notify(strategy: NotificationHub::Notification::Strategy::Multichannel)

# Sends the messages until the first one works
notification_hub.notify(strategy: NotificationHub::Notification::Strategy::Fallback)
```

OR

```ruby
require 'notification_hub'

push_notification = NotificationHub::Channels::Messages::PushNotification.new(
	device_token: ['Receiver\'s Api-ID'],
    title: 'Title',
    link: 'Deep link',
    body: 'Message'
)

sms = NotificationHub::Channels::Messages::Sms.new(
	phone_number: '+55DDNNNNNNNNN',
    body: 'Message'
)

notification_hub = NotificationHub::Notification.new(
	messages: [push_notification, sms]
	options: {
		receiver_id: receiver.id,
		receiver_type: 'Receiver',
		reason_id: reason.id,
		reason_type: 'Reason'
	}
)

# Sends push notification and sms
notification_hub.notify(strategy: NotificationHub::Notification::Strategy::Multichannel)

# Sends the messages until the first one works
notification_hub.notify(strategy: NotificationHub::Notification::Strategy::Fallback)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/truckpad/notification-hub-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
