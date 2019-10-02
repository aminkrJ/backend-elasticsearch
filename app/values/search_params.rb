class SearchParams < Struct.new(:query, :start_date, :end_date, :interval)
  include ActiveModel::Model

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :interval, presence: true
  validates :query, presence: true
end
