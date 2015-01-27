require 'spec_helper'

describe AddressCapture do

  before(:each) do
    @address = '29 Acacia Road, Nuttytown, BAN 123'
  end

  it "should post to Sorting Office" do
    expect(HTTParty).to receive(:post).with("http://sorting-office.openaddressesuk.org/address", body: {
                                  address: @address,
                                  contribute: true
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
