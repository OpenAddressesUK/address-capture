require 'rack/test'
require './lib/address-capture'
require 'pry'

module RSpecMixin
  include Rack::Test::Methods
  def app() AddressCapture end
end

RSpec.configure do |config|
  config.include RSpecMixin
end
