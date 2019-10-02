module ElasticsearchClient
  module Filter
    class Range
      attr_accessor :query, :format, :start_millis, :end_millis

      def initialize(query:, format:, start_millis:, end_millis:)
        @query = query
        @format = format
        @start_millis = start_millis
        @end_millis = end_millis
      end

      def to_h
        {
          bool: {
            must: [
              {
                range: {
                  timestamp: {
                    format: format,
                    gte: start_millis,
                    lte: end_millis
                  }
                }
              }
            ],
            filter: {
              multi_match: {
                query: query
              }
            }
          }
        }
      end
    end
  end
end
