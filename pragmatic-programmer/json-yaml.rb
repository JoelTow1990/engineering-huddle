require 'json'
require 'yaml'

directory = ARGV[0] ? ARGV[0] : Dir.pwd
delete = ARGV[1] == "true" ? true : false

yaml_files = Dir.glob("#{directory}/*{yaml,yml}")
yaml_files.each do |file|
  
  json_text = json.pretty_generate(yaml.load_file(file))
  filename = "#{file.split('.').first}.json"
  File.open(filename, 'w').write(json_text)

  if delete
    File.delete(file)
  end
end
