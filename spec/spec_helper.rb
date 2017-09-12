Dir['./spec/support/**/*.rb'].each { |f| require f }

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require 'notification_hub'
