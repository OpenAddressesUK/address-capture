require 'sinatra'
require 'dotenv'
require 'httparty'

Dotenv.load

class AddressCapture < Sinatra::Base

  post '/' do
    unless !params['agree_to_terms'].empty?
      HTTParty.post("http://sorting-office.openaddressesuk.org/address", body: {
          address: params['address'],
          contribute: true
      })
    end

    redirect to ENV['THANK_YOU_PAGE']
  end

end
