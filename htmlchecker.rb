require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'

# response = URI.parse('https://en.wikipedia.org/wiki/Fewiofewjio')
# response = Net::HTTP.get_response(response)
# puts JSON.parse(response.body)




require "net/http"
url = URI.parse("https://en.wikipedia.org/wiki/fewjiofweio")
req = Net::HTTP.new(url.host, url.port)
req.use_ssl = true
res = req.request_head(url.path)

puts res.code 