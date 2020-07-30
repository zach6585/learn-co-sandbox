require 'nokogiri'
require 'open-uri'
require 'net/http'



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
    puts "Input 'yes' to play."
    puts "Input 'no' to quit."
    puts "Input 'rules' to read the rules of the game."
    a = gets.chomp
    if a == 'rules'
      rules 
    elsif a == "yes"
      puts "What wikipedia page do you want to start on?"
      b = gets 
      link = "https://en.wikipedia.org/wiki/#{c.capitalize}"
      url = URI.parse(link)
      req = Net::HTTP.new(url.host, url.port)
      res = req.request_head(url.path)
      if res.code == 200 
        runner(link)
      else 
        begin
          raise FakepageError
          rescue FakepageError => error
          puts error.message
        end 
        getters 
      end 
    elsif a == "no"
      puts "Goodbye!"
      return 
    end 
  end 
    
  class RecursionError < SystemStackError 
    def message 
      "It doesn't seem like you're going to reach it :(..."
    end 
  end 
  
  class FakepageError < OpenURI::HTTPError 
    def message
      "It doesn't seem like this is a real page. Try again!"
    end 
  end 
  def runner(link)
    puts 'here'
  end 
end 
      
  
  
  
  
  
    
    
    
tryal = Wikispeed.new 

tryal.getters
    
    
    
    
    
    
      
  # end 
  
  # def runner(link)
  #   # begin 
  #   # raise RecursionError
  #   # rescue RecursionError => error 
  #   #   puts error.message
  #   # end 
  # end 
  
 

"Conveniently, the Wiki page for philosophy has a disambiguation, a link in a parenthesis, and a regular link (plus is the end goal which is nice to set)"

"May also (probably should honestly) make a second game where it's a race to see how fast. It'll track time and how many rounds it takes you, plus visited so far."