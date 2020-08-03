require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'url_expander'



class Wikispeed
  @@all = []
  def initialize
    @count = 0 
    @path = []
  end 
  
  def rules 
    puts "Wikispeedia is simple. You start at a Wikipedia of your choosing. From that page, one would click the first link, which is the text highlighted in blue, that isn't a disambiguation or in parentheses. One would keep doing this until you get to the goal page, which is Philosophy."
    getters
  end 
  
  def getters
    puts "Hello! Welcome to Wikispeedia a la Zach!"
    puts "Do you want to play?"
    puts "Input 'y' to play."
    puts "Input 'n' to quit."
    puts "Input 'r' to read the rules of the game."
    a = gets.chomp
    if a == 'r'
      rules 
    elsif a == "y"
      puts "What wikipedia page do you want to start on?"
      b = gets.chomp
      link = "https://en.wikipedia.org/wiki/#{b.capitalize}"
      url = URI.parse(link)
      req = Net::HTTP.new(url.host, url.port)
      req.use_ssl = true
      res = req.request_head(url.path)
      if res.code.to_i == 200 
        runner(link)
      else 
        puts "That link doesn't work! Try again"
        getters 
      end 
    elsif a == "n"
      puts "Goodbye!"
      return 
    else 
      puts "Not a valid response, please try again."
    end 
  end 
  
  
  def runner(link)
    @count += 1 
    q = nil 
    uri = Nokogiri::HTML(open(link))
    uri.css('p').each do |p|
      q = p unless p.css('b').to_s.strip.empty?
    end 
    if !@path.include?(q.css('b').text)
      @path << q.css('b').text
      words = q.text.split(' ')
      words2 = []
      i = 0 
      words.each do |elem|
        if elem.include?(')')
          i = 2 
        elsif elem.include?('(')
          i = 1 
        end 
        if i == 0 
          words2 << elem
        elsif i == 2 
          i = 0 
        end 
      end 
      # fin_elem = nil 
      # q.css('a').each do |elem|
      #   puts elem 
      #     puts 'here'
      #   words2.each do |item| 
      #     if item.include?(elem.text)
      #       if fin_elem == nil 
      #         fin_elem = elem
      #       end 
      #     end 
      #   end 
      # end 
      puts words2
    #   if "https://en.wikipedia.org#{fin_elem["href"]}" == "https://en.wikipedia.org/wiki/Philosophy"
    #     i = 1
    #     puts "We made it! It only took us #{@count} steps!"
    #   else 
    #     # puts "We didn't make it this round, so in we go again!"
    #     runner("https://en.wikipedia.org#{fin_elem["href"]}")
    #   end 
    # else 
    #   puts "You got caught in a loop :("
    #   return 
    # end 
  end 
end 
      
  
  
  
  
  
    
    
    
tryal = Wikispeed.new 

# tryal.getters
tryal.getters 
    
    
 

"Conveniently, the Wiki page for philosophy has a disambiguation, a link in a parenthesis, and a regular link (plus is the end goal which is nice to set)"

"May also (probably should honestly) make a second game where it's a race to see how fast. It'll track time and how many rounds it takes you, plus visited so far."