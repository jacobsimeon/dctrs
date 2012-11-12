ENV['ELASTICSEARCH_URL'] = 'http://xq0vkvx0:ido6siqdctum40h5@holly-4358549.us-east-1.bonsai.io'

if Rails.env.test?
  prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
  Tire::Model::Search.index_prefix(prefix)
end

