require 'spec_helper'

RSpec.describe NotificationHub::Envelope::Fallback do
  subject { NotificationHub::Envelope::Fallback.new(messages: [], options: {}) }
  it { is_expected.to be_kind_of(NotificationHub::Envelope::Base) }
  it { expect(subject.strategy).to eq('fallback') }
end
