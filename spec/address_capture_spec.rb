require 'spec_helper'

describe AddressCapture do

  before(:each) do
    @address = '29 Acacia Road, Nuttytown, BAN 123'
  end

  it "should post to Google Docs" do
    expect(HTTParty).to receive(:post).with(ENV['GOOGLE_DOCS_FORM_URL'], body: {
                                  "#{ENV['GOOGLE_DOCS_ADDRESS_ELEMENT']}" => @address,
                                  "#{ENV['GOOGLE_DOCS_IP_ADDRESS_ELEMENT']}" => '127.0.0.1',
                                  "#{ENV['GOOGLE_DOCS_USER_AGENT_ELEMENT']}" => "Not provided",
                                  "draftResponse" => "[,,\"-5388958579521340185\"]",
                                  "fbzx" => "-5388958579521340185",
                                  "pageHistory" => 0
                              })

    post '/', {
      'address' => @address,
      'agree_to_terms' => ""
    }

    expect(last_response.status).to eq(302)
    expect(last_response.header['Location']).to eq(ENV['THANK_YOU_PAGE'])
  end

  it "should not post if the honeypot is present" do
    expect(HTTParty).not_to receive(:post)

    post '/', {
      'address' => @address,
      'agree_to_terms' => "1"
    }
  end

end
