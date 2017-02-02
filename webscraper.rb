require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'Pry'
require 'csv'

vehicle = "m3"

page = HTTParty.get("https://toronto.craigslist.ca/search/cta?query=#{vehicle}")

parse_page = Nokogiri::HTML(page)

cars = []

parse_page.css('.result-info').css('.hdrlnk').map do |a|
  post_name = a.text
  cars.push(post_name)
end

CSV.open('cars.csv', 'w') do |csv|
  csv << cars
end

Pry.start(binding)
