

if Rails.env.production?
  ENV['ELASTICSEARCH_URL'] = 'http://jacob:7dwarves@searc1.dctrs.io:8080'
else
  ENV['ELASTICSEARCH_URL'] = 'http://localhost:9200'
end

if Rails.env.test?
  prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
  Tire::Model::Search.index_prefix(prefix)
end

