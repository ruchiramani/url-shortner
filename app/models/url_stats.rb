class UrlStats < ActiveRecord::Base
  belongs_to :url

  def update_histogram
    self.times_visited += 1
    self.save
  end

  def self.generate_histogram(url_id)
    url_stats = UrlStats.where(url_id: url_id)
    histogram = {}
    url_stats.each do |st|
      histogram[st.date] =  st.times_visited
    end
    return histogram
  end

end
