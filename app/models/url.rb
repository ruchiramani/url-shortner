class Url < ActiveRecord::Base

  has_many :url_stats
  validate :shorten, :valid_url?
  validates :original,uniqueness: true, presence: true
  validates :short, presence: true,uniqueness: true
  LENGTH = 5

  def generate_url
    source=("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a + ["_","-","."]
    key=""
    LENGTH.times{ key += source[rand(source.size)].to_s }
    return key
  end

  def shorten
    binding.pry
    self.short =  self.generate_url if self.short.nil?
  end

  def update_visit
    self.visited += 1
    self.save
    date = Date.current
    stat = UrlStats.find_or_initialize_by(url_id: self.id, date: date)
    stat.save
    stat.update_histogram
  end

  def valid_url?
    url = self.original
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    self.domain = uri.host.start_with?('www.') ? uri.host[4..-5] : uri.host
   rescue URI::InvalidURIError
    false
  end

end
