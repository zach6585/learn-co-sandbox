require 'nokogiri'
require 'open-uri'
require 'net/http'




i = 0 
bads = []
elems = {}
while i < 10 
  uri = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Special:Random"))
  uri.css('a').each do |a|
    if !bads.include?(a['href'])
      if !elems.key?(a['href'])
        elems[a['href']] = 1 
      else 
        elems[a['href']] += 1 
        if elems[a['href']] == 7
          bads << a['href']
          elems.delete(a['href'])
        end 
      end 
    elsif elems.key?(a['href'])
      elems[a['href']] += 1 
      if elems[a['href']] >= 7
          bads << a['href']
          elems.delete(a['href'])
      end
    end 
  end 
  puts 'here'
  i += 1 
end 

puts bads

"Conveniently, the Wiki page for philosophy has a disambiguation, a link in a parenthesis, and a regular link (plus is the end goal which is nice to set)"

"May also (probably should honestly) make a second game where it's a race to see how fast. It'll track time and how many rounds it takes you, plus visited so far."


