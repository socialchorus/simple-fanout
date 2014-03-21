module SimpleFanout
  class Client
    attr_reader :key, :id, :channel, :token

    def initialize(opts={})
      @key = opts[:key] || config["realm_key"]
      @id = opts[:id] || config["realm_id"]
      @channel = opts[:channel] || config["default_channel"]
    end

    def token
      @token ||= "#{JWT.encode(claim, decoded_key)}"
    end

    def send(data)
      RestClient.post(url, parse(data), 
        "Content-Type" => "application/json", 
        "Authorization" => "Bearer #{token}")
    end

    private

    def url
      "https://api.fanout.io/realm/#{id}/publish/#{channel}/"
    end

    def config
      @config ||= YAML.load_file('config/simple_fanout.yml')
    end

    def claim
      @claim ||= {'iss' => id, 'exp' => Time.now.to_i + 3600}
    end

    def decoded_key
      Base64.decode64(key)
    end

    def parse(data)
      "{ \"items\": [{ \"fpp\": #{data}}] }"
    end
  end
end
