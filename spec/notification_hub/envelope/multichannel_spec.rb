require 'spec_helper'

RSpec.describe NotificationHub::Envelope::Multichannel do
  subject { NotificationHub::Envelope::Multichannel.new(messages: [], options: {}) }
  it { is_expected.to be_kind_of(NotificationHub::Envelope::Base) }
  it { expect(subject.strategy).to eq('multichannel') }
end
