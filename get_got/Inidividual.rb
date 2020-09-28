require 'nokogiri'
require 'open-uri'
require 'net/http'

uri = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Domestication"))
i = 0 


uri.css('p').each do |el|
  puts el.text
  puts el.css('a')
end 