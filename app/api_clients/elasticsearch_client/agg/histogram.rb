module ElasticsearchClient
  module Agg
    class Histogram
      include ElasticsearchClient::Agg
      attr_accessor :key, :field, :interval

      def initialize(field:, key:, interval:)
        @field = field
        @key = key
        @interval = interval
      end

      def to_h
        hash = {}
        hash[key] = {
          date_histogram: {
            field: field,
            fixed_interval: interval,
            min_doc_count: 0
          }
        }
        hash
      end
    end
  end
end
