require 'spec_helper'

describe SimpleFanout::Client do
  let(:client){ SimpleFanout::Client.new(id: id, key: key) }

  let(:claim) {
    { 'iss' => id, 'exp' => expiration_date  }
  }
  let(:expiration_date) { Time.now.to_i + 3600 }
  let(:id) { "jazzhands" }
  let(:key) { "abcd" }
  let(:data) { 'datadata' }
  let(:url) { "https://api.fanout.io/realm/#{id}/publish/#{channel}/" }
  let(:channel) { "sluice-ride" }
  let(:params) {
    {
      "Content-Type" => "application/json", 
      "Authorization" => "Bearer #{client.token}"
    }
  }

  before do
    Base64.stub(:decode64).and_return("decoded_key")
    JWT.stub(:encode).and_return("YXNpbXB")
  end

  describe "#send" do
    it "should send an HTTP POST request to fanout" do
      RestClient.should_receive(:post).with(url, "{ \"items\": [{ \"fpp\": #{data}}] }", params)
      client.send(data)
    end
  end

  describe "#token" do
    it "should create a token" do
      Base64.should_receive(:decode64).with(key)
      JWT.should_receive(:encode).with(claim, "decoded_key")
      client.token.should == "YXNpbXB"
    end
  end
end