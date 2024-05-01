require 'json'
require 'yaml'

directory = ARGV[0] ? ARGV[0] : Dir.pwd
delete = ARGV[1] == "true" ? true : false

def jsonify_yaml_file(filename)
  JSON.pretty_generate(YAML.load_file(filename))
end

def convert_filename(filename)
  splitname = filename.split('.')
  range = (0...splitname.length - 1)
  "#{splitname[range].join('.')}.json"
end

if __FILE__ == $0
  yaml_files = Dir.glob("#{directory}/*{yaml,yml}")
  yaml_files.each do |file|

    json_text = jsonify_yaml_file(file)
    new_name = convert_filename(filename)
    File.write(new_name, jsonified_text)

    if delete
      File.delete(file)
    end
  end
end