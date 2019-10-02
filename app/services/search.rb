class Search < ApplicationService
  attr_reader :search_params

  INDEX = 'news'

  def initialize(search_params = {})
    @search_params = SearchParams.new.tap do |p|
      p.query = search_params[:query]
      p.start_date = search_params[:start_date]
      p.end_date = search_params[:end_date]
      p.interval = search_params[:interval]
    end
  end

  def call
    if search_params.valid?
      query = SearchQuery.new(search_params).to_json
      begin
        resp = ElasticsearchClient::Search.search(INDEX, query)
        OpenStruct.new(success?: true, response: resp)
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

    def to_json
      term = ElasticsearchClient::Agg::Term.new(field: 'medium', key: 'second_agg')
      histogram = ElasticsearchClient::Agg::Histogram.new(field: 'timestamp', key: 'first_agg', interval: @search_params.interval)
      filter = ElasticsearchClient::Filter::Range.new(format: "epoch_millis", start_millis: @search_params.start_millis, end_millis: @search_params.end_millis, query: @search_params.query)
      {
        aggs: histogram.merge(term),
        query: filter.to_h
      }.to_json
    end
  end
end
