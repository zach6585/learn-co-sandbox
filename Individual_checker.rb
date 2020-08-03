require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'url_expander'


i = 0
uri = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Propulsion"))
uri.css('p').each do |p|
  if i < 10 
    if !p.text.strip.empty?
      puts p.css('i')
      i +=1 
    end 
  end 
end 
    
 

"Conveniently, the Wiki page for philosophy has a disambiguation, a link in a parenthesis, and a regular link (plus is the end goal which is nice to set)"

"May also (probably should honestly) make a second game where it's a race to see how fast. It'll track time and how many rounds it takes you, plus visited so far."


