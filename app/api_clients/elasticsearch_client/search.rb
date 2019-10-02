module ElasticsearchClient
  class Search
    def self.search(index, body)
      ElasticsearchClient.client.search(index: index, body: body)
    end
  end
end
