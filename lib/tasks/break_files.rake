task :break_files do
  root = "/Volumes/Data/Users/jacobsimeon/Projects/jacobsimeon/providers"
  provider_file_name = 'npidata_20050523-20120709.csv'
  provider_file = File.join root, provider_file_name 
  new_files_dir = File.join root, 'providers' 

  puts "Will break apart #{provider_file}"
  puts "Will place smaller files in #{new_files_dir}"

  puts "Counting total lines in provider file"
  total_lines = 3717914 #(`wc -l #{provider_file}`).to_i

  puts "Total Lines: #{total_lines}"

  max_file_lines = 10000

  big_file = File.open(provider_file)
  headers = big_file.readline

  file_no = 0
  while !big_file.eof?
    filename = File.join new_files_dir, provider_file_name.sub('.csv', "_#{"%05d" % file_no}.csv")
    small_file = File.open(filename, 'w+')
    small_file.puts headers
    lines_read = 0
    while lines_read < max_file_lines and !big_file.eof?
      small_file.puts big_file.readline    
      lines_read += 1
    end
    puts "Wrote #{lines_read} lines to file ##{file_no}"
    file_no += 1
  end

end
