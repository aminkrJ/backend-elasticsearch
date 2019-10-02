class SearchParams < Struct.new(:query, :start_date, :end_date, :interval)
  include ActiveModel::Model

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :interval, presence: true
  validates :query, presence: true

  # this can go to a decorator
  def start_millis
    DateTime.parse(start_date).strftime('%Q')
  end

  # this can go to a decorator
  def end_millis
    DateTime.parse(end_date).strftime('%Q')
  end
end
