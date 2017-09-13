require 'spec_helper'

RSpec.describe NotificationHub do
  it { expect(NotificationHub).to respond_to(:configure) }
  it { expect(NotificationHub.configuration).to be_a(NotificationHub::Configuration) }
  it { expect(NotificationHub.reset).to be_a(NotificationHub::Configuration) }
end
