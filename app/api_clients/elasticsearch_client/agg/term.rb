module ElasticsearchClient
  module Agg
    class Term
      include ElasticsearchClient::Agg
      attr_accessor :key, :field

      def initialize(field:, key:)
        @field = field
        @key = key
      end

      def to_h
        hash = {}
        hash[key] = {
          terms: {
            field: field,
            min_doc_count: 0
          }
        }
        hash
      end
    end
  end
end
