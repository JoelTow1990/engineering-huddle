File.open('wordlist.txt', "r:ISO-8859-1") do |file|
  file.readlines.each do |line|
    puts line.encode('utf-8')
  end
end
