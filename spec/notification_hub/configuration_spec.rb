require 'spec_helper'

RSpec.describe NotificationHub::Configuration do
  it { is_expected.to respond_to(:notification_dispatcher_queue) }
  it { is_expected.to respond_to(:aws_sqs_url) }
  it { is_expected.to respond_to(:aws_access_key_id) }
  it { is_expected.to respond_to(:aws_secret_access_key) }
  it { is_expected.to respond_to(:aws_region) }
end
