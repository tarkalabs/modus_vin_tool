$LOAD_PATH.unshift File.dirname(__FILE__)

require 'modus_vin_tool'
require 'dotenv'
Dotenv.load
RSpec.configure do |config|
  config.color = true
end