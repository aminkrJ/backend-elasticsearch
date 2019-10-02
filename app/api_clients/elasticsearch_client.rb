require 'elasticsearch'

module ElasticsearchClient
  class << self
    def client
      config = ElasticsearchClient::Config.new.tap { |config| yield(config) if block_given? }
      Elasticsearch::Client.new(config.to_h)
    end
  end
end
