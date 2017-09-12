require 'spec_helper'

RSpec.describe NotificationHub::Channels::Messages::Base do
  let(:body) { 'Test' }

  subject { NotificationHub::Channels::Messages::Base.new(body) }

  describe '#initialize' do
    it { expect(subject.body).to eq(body) }
  end

  describe '#to_hash' do
    class NotificationHub::Channels::Messages::Test < NotificationHub::Channels::Messages::Base
      def channel
        'test'
      end
    end

    subject { NotificationHub::Channels::Messages::Test.new(body) }
    it { expect(subject.to_hash).to eq(Hash[channel: 'test', body: body]) }
  end
end
