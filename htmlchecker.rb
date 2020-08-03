require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'

# response = URI.parse('https://en.wikipedia.org/wiki/Fewiofewjio')
# response = Net::HTTP.get_response(response)
# puts JSON.parse(response.body)



# url = URI.parse('https://en.wikipedia.org/wiki/Baby')
#       req = Net::HTTP.new(url.host, url.port)
#       req.use_ssl = true
#       res = req.request_head(url.path)


url = Nokogiri::HTML(open('https://en.wikipedia.org/wiki/Philosophy'))

# puts res.code 
i = 0 

url.css('p').each do |p|
  puts p.text unless p.css('b').to_s.strip.empty?
  i += 1 
 end 
