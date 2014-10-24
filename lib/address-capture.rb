require 'sinatra'
require 'dotenv'
require 'httparty'

Dotenv.load

class AddressCapture < Sinatra::Base

  post '/' do
    unless !params['agree_to_terms'].nil?
      HTTParty.post(ENV['GOOGLE_DOCS_FORM_URL'], query: {
          "#{ENV['GOOGLE_DOCS_ADDRESS_ELEMENT']}" => params['address'],
          "#{ENV['GOOGLE_DOCS_IP_ADDRESS_ELEMENT']}" => request.ip,
          "#{ENV['GOOGLE_DOCS_USER_AGENT_ELEMENT']}" => request.user_agent || "Not provided",
          "draftResponse" => "[,,\"-5388958579521340185\"]",
          "fbzx" => "-5388958579521340185",
          "pageHistory" => 0
      })
    end

    redirect to ENV['THANK_YOU_PAGE']
  end

end