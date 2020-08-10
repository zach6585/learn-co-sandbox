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

ty = Wikipedia.new("https://en.wikipedia.org/wiki/Cat",1)
ty.runner(ty.link)


