=begin
task :split_file, :file do |t, args|

  FILE_NAME = 'providers.csv'
  OUT_DIR = 'providers'
  NUM_FILES = 10

  headers = `head -1 #{FILE_NAME}`
  num_lines = `sed -n '$=' #{FILE_NAME}`.to_i

  puts "Total lines in parent file: #{num_lines}"

  file_size = ((num_lines + NUM_FILES - (num_lines % NUM_FILES)) / NUM_FILES) - 1

  puts "Splitting into files with #{file_size} lines"

  `rm -rf #{OUT_DIR}` if File.exists?(OUT_DIR) && File.directory?(OUT_DIR)
  `mkdir -p #{OUT_DIR}`
  `split -a 2 -l #{file_size} #{FILE_NAME} #{OUT_DIR}/providers_`

  file_count = 0
  threads = []
  Dir.foreach(OUT_DIR) do |file_name|
    next if file_name == '.' or file_name == '..'
    full_name = "#{OUT_DIR}/#{file_name}"
    `gzip #{full_name}`
    end
  end

  threads.each { |t| t.join }
end
=end
