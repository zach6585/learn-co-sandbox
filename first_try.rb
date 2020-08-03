require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'url_expander'



class Philosophy
  @@fails = []
  @@successes = []
    attr_accessor :path, :count
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
    if link == "https://en.wikipedia.org/wiki/Philosophy"
        puts "We made it! It only took us #{@count} steps!"
        @@successes << self 
        return 
    end 
    @count += 1 
    q = nil 
    title = nil
    uri = Nokogiri::HTML(open(link))
    uri.css('p').each do |p| #Purpose of this is to get a title 
      title = p unless p.css('b').to_s.strip.empty?
      i = 0 
      p.css('a').each do |elem|
        if !elem.text.include?('[')
          i += 1 
        end 
      end 
      if i != 0 
        if q == nil 
          q = p unless p.text.strip.empty?
        end 
      end 
    end
    if !@path.include?(q.css('b').text)
      @path << title.css('b').text
      words = q.text.split('')
      lks = {}
      q.css('a').each do |lk|
        lks[lk.text] = lk unless lk.text.include?('[')
      end 
      i = 0 
      text = ''
      words.each do |char|
        if char == '('
          i += 1  
        elsif char == ')'
          i -= 1 
        end 
        if i == 0 
          text += char 
        end 
      end 
      fin_elem = nil 
      lks.each do |k,v|
        if text.include?(k)
          if fin_elem == nil 
            fin_elem = v['href']
          end 
        end 
      end 
      runner("https://en.wikipedia.org#{fin_elem}")
      
    else 
      puts "You got caught in a loop :("
      @@fails << self 
      return 
    end 
  end 
end 
      
  
  
  
  
  
i = 0     
    

    
 

"Conveniently, the Wiki page for philosophy has a disambiguation, a link in a parenthesis, and a regular link (plus is the end goal which is nice to set)"

"May also (probably should honestly) make a second game where it's a race to see how fast. It'll track time and how many rounds it takes you, plus visited so far."