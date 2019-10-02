class SearchController < ApplicationController
  def results
    result = Search.call(search_params)

    if result.success?
      render json: result.response.slice("aggregations")
    else
      render json: { message: result.message }
    end
  end

  private

  def search_params
    params.permit(:query, :start_date, :end_date, :interval)
  end
end
