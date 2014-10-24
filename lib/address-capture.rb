require 'sinatra'
require 'dotenv'
require 'httparty'

Dotenv.load

class AddressCapture < Sinatra::Base

  post '/' do
    unless !params['agree_to_terms'].empty?
      HTTParty.post(ENV['GOOGLE_DOCS_FORM_URL'], body: {
          "#{ENV['GOOGLE_DOCS_ADDRESS_ELEMENT']}" => params['address'],
          "#{ENV['GOOGLE_DOCS_IP_ADDRESS_ELEMENT']}" => request.ip,
          "draftResponse" => ENV['GOOGLE_DOCS_DRAFT_RESPONSE_VALUE'],
          "fbzx" => ENV['GOOGLE_DOCS_FBZX_VALUE'],
          "pageHistory" => 0
      })
    end

    redirect to ENV['THANK_YOU_PAGE']
  end

end
