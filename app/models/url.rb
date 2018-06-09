class Url < ActiveRecord::Base
  LENGTH = 5
  validate :shorten, :valid_url?
  validates :original,uniqueness: true, presence: true
  validates :short, presence: true

  def generate_url
    source=("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a + ["_","-","."]
    key=""
    LENGTH.times{ key += source[rand(source.size)].to_s }
    return key
  end

  def shorten
    self.short =  self.generate_url if self.short.nil?
  end


  def valid_url?
    url = self.original
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
    self.domain = uri.host
   rescue URI::InvalidURIError
    false
  end

end
