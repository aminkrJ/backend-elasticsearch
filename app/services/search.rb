class Search < ApplicationService
  attr_accessor :search_params

  INDEX = 'news'

  def initialize(search_params)
    @search_params = search_params
  end

  def call
    if search_params.valid?
      query = SearchQuery.new(search_params).to_json
      begin
        resp = ElasticsearchClient::Search.search(INDEX, query)
        OpenStruct.new(success?: true, data: resp)
      rescue StandardError => e
        OpenStruct.new(success?: false, message: e.message)
      end
    else
      OpenStruct.new(success?: false, message: search_params.errors.full_messages[0])
    end
  end

  class SearchQuery
    def initialize(search_params)
      @search_params = search_params
    end

    def to_millis(date_string)
      DateTime.parse(date_string).strftime('%Q')
    end

    def query
      term = ElasticsearchClient::Agg::Term.new(field: 'medium', key: 'second_agg')
      histogram = ElasticsearchClient::Agg::Histogram.new(field: 'timestamp', key: 'first_agg', interval: @search_params.interval)
      filter = ElasticsearchClient::Filter::Range.new(format: "epoch_millis", start_millis: to_millis(@search_params.start_date), end_millis: to_millis(@search_params.end_date), query: @search_params.query)
      {
        aggs: histogram.merge(term),
        query: filter.to_h
      }
    end

    def to_json
      query.to_json
    end
  end
end
