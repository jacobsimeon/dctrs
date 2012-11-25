task :s3, :dir do |t, args|
  require 'aws-sdk'
  require 'pp'
  
  OUT_DIR = args[:dir]

  bucket_name = "dctrs_io_imports"

  AWS.config({
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  })

  s3 = AWS::S3.new
  dctrs_io_imports = s3.buckets[bucket_name]

  threads = []
  Dir.foreach(OUT_DIR) do |file_name|
    next if file_name == '.' or file_name == '..'
    full_name = "#{OUT_DIR}/#{file_name}"

    threads << Thread.start do 
      import_file = dctrs_io_imports.objects[File.basename(full_name)]
      object.write file: full_name
    end
  end

  threads.each { |t| t.join }
end

