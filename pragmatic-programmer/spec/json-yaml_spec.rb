require_relative '../json-yaml'
require 'securerandom'
require 'json'
require 'yaml'

RSpec.describe "json-yaml script methods" do

    context 'the filename conversion function works' do
        let(:yaml_files) do
            files = []
            1000.times do |_|
                random_text =  SecureRandom.uuid
                files << random_text + '.yml'
                files << random_text + '.yaml'
            end
            files
        end

        it 'correctly converts yaml to json' do
            yaml_files.each do |file|
                expect(convert_filename(file)).to end_with('.json')
            end
        end
    end

    context ' the jsonify function works' do
        let(:create_test_data) do
            data = {
                'key1' => SecureRandom.alphanumeric(10),
                'key2' => SecureRandom.alphanumeric(10),
                'key3' => SecureRandom.alphanumeric(10),
                'key4' => SecureRandom.alphanumeric(10),
                'nested_key' => {
                  'nested_key1' => SecureRandom.alphanumeric(10),
                  'nested_key2' => SecureRandom.alphanumeric(10),
                }
            }
        end

        def setup_yaml_file(data)
            File.write('test.yaml', YAML.dump(data))
        end

        let(:destroy_test_data) do
            File.delete('test.yaml')
        end

        it 'correctly converts yaml to json' do
            1000.times do |_|
                data = create_test_data
                setup_yaml_file(data)
                from_yaml = YAML.load_file('test.yaml')
                from_json = JSON.parse(jsonify_yaml_file('test.yaml'))
                expect(from_json).to eq(from_yaml)
            end
            destroy_test_data
        end
    end
end