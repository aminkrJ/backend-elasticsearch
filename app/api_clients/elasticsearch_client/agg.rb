module ElasticsearchClient
  module Agg
    def merge(another_agg)
      current_hash = self.to_h
      current_hash[self.key]["aggs"] = another_agg.to_h
      current_hash
    end
  end
end
