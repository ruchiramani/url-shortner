# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
case Rails.env
when 'development'
   urls = ['https://www.google.com', 'https://www.apple.com', 'https://www.mobilizeamerica.io/']
   urls.each do |i|
     new = Url.create(original: i)
     new.save
  end
end
