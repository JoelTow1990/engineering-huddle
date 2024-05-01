extension = ARGV[0] ? ARGV[0] : '.rb'
replace = ARGV[1] == "true" ? true : false

def report_camel_case(filename)
  File.read(filename).split("\n")
    .each_with_index do |line, line_number|
    
      line.scan(/[a-z]+[A-Z]\w*/) do |camel_case|
      puts "line #{line_number + 1}: #{camel_case}"
    end
  end
end

def replace_case(filename)
  content = File.read(filename)
  camel_case_words = []
  content.scan(/[a-z]+[A-Z]\w*/) { |word| camel_case_words << word }
  new_content = content.dup

  camel_case_words.each do |word|
    new_word = word.gsub(/([A-Z])/, "_\\1").downcase
    new_content.gsub!(word, new_word)
  end

  if content != new_content
    File.write(filename, new_content)
    File.write("#{filename}.backup", content)
  end
end


files = Dir.glob("./*#{extension}")
files.each do |file|
  report_camel_case(file)

  if replace
    replace_case(file)
  end
end
