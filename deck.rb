uri.css('p').each do |p| 
      eyes = []
      p.css('i').each do |i|
        eyes << i 
      end 
      words = p.text.split('')
      lks = {}
      p.css('a').each do |lk|
        lks[lk.text] = lk unless (lk.text.include?('[') || (lk['title'].include?('wiktionary') if lk['title'])) 
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