class SearchParams < Struct.new(:query, :start_date, :end_date, :interval)
  include ActiveModel::Model

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :interval, presence: true
  validates :query, presence: true

  def self.build(hash)
    new.tap do |p|
      p.query = hash[:query]
      p.start_date = hash[:start_date]
      p.end_date = hash[:end_date]
      p.interval = hash[:interval]
    end
  end
end
