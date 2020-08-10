require 'nokogiri'
require 'open-uri'
require 'net/http'


class Wikipedia
  @@fails = 0
  @@successes = 0
  @@all = []
    attr_accessor :path, :count
    attr_reader :link
  def initialize(link, choice)
    @choice = choice 
    @link = link 
    @count = 0
    @path = []
    if @choice == 1 
      @@all << self
    end 
  end

  def self.successes
    @@successes
  end

  def self.fails
    @@fails
  end
  
  def self.all 
    @@all 
  end 
  
  def runner(link)
    if link == "https://en.wikipedia.org/wiki/Science"
      puts "We made it! It only took us #{@count} steps!"
      @@successes += 1
      if @choice == 1 
        puts "Want to see the path you took? [y/n]"
        aa = gets.chomp
        if aa == 'y'
          acc = 1
          @path.each do |elem|
            elem = elem.gsub("_"," ")
            puts "#{acc}. #{elem}"
            acc += 1 
          end 
        end
      end 
      return
    end
    @count += 1
    i = 0
    fin_elem = nil
    uri = Nokogiri::HTML(open(link))
    uri.css('p').each do |p|
      eyes = []
      p.css('i').each do |i|
        eyes << i
      end
      words = p.text.split('')
      lks = {}
      p.css('a').each do |lk|
        lks[lk.text] = lk unless (lk.text.include?('[') || (lk['title'].include?('wiktionary' || 'Category') if lk['title']) || (lk['class'] == 'image' if lk['class']))
      end
      i = 0
      text = ''
      words.each do |char|
        if char == '(' || char == '['
          i += 1
        elsif char == ')' || char == ']'
          i -= 1
        end
        if i == 0
          text += char
        end
      end
      lks.each do |k,v|
        if text.include?(k)
          if fin_elem == nil
            fin_elem = v['href'] unless (v['title'] == "About this sound" || eyes.include?(v))
          end
        end
      end
      if fin_elem.to_s.strip.empty?
        fin_elem = nil
      end
    end

    if fin_elem == nil || !fin_elem.include?('wiki')
      @@fails +=1
      return
    end
    end_fin = fin_elem.split('')
    i = 0
    fin_elem = ''
    end_fin.each do |e|
      if e == '#'
        i += 1
      end
      if i == 0
        fin_elem += e
      end
    end

    if !@path.include?(fin_elem[6...])
      @path << fin_elem[6...]
      runner("https://en.wikipedia.org#{fin_elem}")
    else
      puts "You got caught in a loop :("
      @@fails += 1
      if @choice == 1 
        puts "Want to see the path you took? [y/n]"
        aa = gets.chomp
        if aa == 'y'
          puts @path
          acc = 1
          @path.each do |elem|
            elem = elem.gsub("_"," ")
            puts "#{acc}. #{elem}"
            acc += 1 
          end 
        end
      end 
      return
    end
  end
end



def rules
  puts "The game is simple. You start at a Wikipedia page of your choosing. From that page, you click the first link, (which is the text highlighted in blue), that isn't a disambiguation, italicized, or in parentheses. Then you keep doing this until you get to the goal page, which is Science."
  getters
end

def getters
  puts "Hello! Welcome to Wikispeedia a la Zach!"
  puts "Do you want to play?"
  puts "Input 'y' to play."
  puts "Input 'n' to quit."
  puts "Input 'r' to read the rules of the game."
  c = nil
  a = gets.chomp
  if a == 'r'
    rules
  elsif a == "y"
    while c != "s" or c!= "b"
      puts "Want to run it a bunch of times or do you want to run it for a specific page?"
      puts "Input 's' for a specific page"
      puts "'b' for a bunch of times"
      c = gets.chomp
      if c == 's'
        bb = 0 
        while bb == 0 
          k = 0 
          puts "What wikipedia page do you want to start on?"
          b = gets.chomp
          link = "https://en.wikipedia.org/wiki/#{b.capitalize}"
          Wikipedia.all.each do |el|
            if el.link == link 
              k +=1 
              puts "You've done this one already. Try again!"
            end 
          end 
          if k == 0 
            url = URI.parse(link)
            req = Net::HTTP.new(url.host, url.port)
            req.use_ssl = true
            res = req.request_head(url.path)
            if res.code.to_i == 200
              new = Wikipedia.new(link,1)
              new.runner(new.link)
              enders(1)
              bb += 1 
              return
            else
              puts "That link doesn't work! Try again"
            end
          end 
        end 
      elsif c == 'b'
        j = 0 
        while j == 0 
          puts "How many times do you want to loop?"
          int = gets.chomp
          if int.gsub(/[^0-9]/,"").strip.empty?
            puts "Not a number. Please try again."
          else 
            j += 1 
          end 
        end 
        int = int.to_i
        i = 0 
        while i <= int 
          tryal = Wikipedia.new("https://en.wikipedia.org/wiki/Special:Random",0)
          tryal.runner(tryal.link)
          i += 1
        end
        enders(0)
        return
      else
        puts "Not a valid response, please try again."
      end
    end
  elsif a == "n"
    puts "Goodbye!"
    return
  else
    puts "Not a valid response, please try again."
    getters
  end
end

def enders(num)
  aa = 0
  if num == 0 
    puts "So far, the overall success rate is #{((Wikipedia.successes.to_f/(Wikipedia.successes + Wikipedia.fails))*100).round(2)}%"
  end 
  while aa == 0
    puts "Wanna try again? [y/n]"
    q = gets.chomp
    if q == 'y'
      aa += 1
      getters
    elsif q == 'n'
      aa += 1
      puts "Goodbye!"
    else
      puts "Incorrect input"
    end
  end
end
getters
