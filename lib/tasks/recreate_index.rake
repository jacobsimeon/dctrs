task :recreate_index => :environment do
  Provider.recreate_index
  Provider.index.import Provider.all
end
