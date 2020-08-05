require 'nokogiri'
require 'open-uri'
require 'net/http'

class Wikispeed
    @@all 
    attr_accessor :time, :user_name, :path, :opponent
  def initialize
    @user_name = ""
    @opponent = ""
    @time = 0
    @path = []
  end 
  
  def runner(start_link)
    beginning = Time.now 
    bads = nil
    uri = Nokogiri::HTML(open(start_link))
    File.open('bads.rb', 'r').each do |elem|
      bads = Array(elem) unless elem.to_s.strip.empty?
    end 
    i = 1
    uri.css('a').each do |a| 
      if !a.text.gsub(/[^a-zA-Z0-9 ]/,"").empty? && a.text.gsub(/[^a-zA-Z0-9 ]/,"") == a.text.strip && !a['href'].to_s.strip.empty? && !a['href'].to_s.strip.include?(':') && !a['href'].to_s.strip.include?('.') && a['href'][0] != '#' && !bads.include?(a['href']) && !a['class'] 
          puts "#{i}. #{a.text}" 
          i += 1 
      end 
    end 
  end 
end 

trial = Wikispeed.new 
trial.runner('https://en.wikipedia.org/wiki/Philosophy')


#This isn't basically possible without a visual representation. There are too many links. I should discuss it with Chet before fully scrapping it. In the meantime, we should focus on the visuals of the first game
