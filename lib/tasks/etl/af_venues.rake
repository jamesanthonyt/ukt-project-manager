require 'af_venues_importer'

namespace :etl do
  task :af_venues => [
    'af_venues:extract',
    'af_venues:load'
  ]

  namespace :af_venues do
    task extract: :environment do
      puts 'Downloading af-venues.csv from S3'
      AfVenuesImporter.extract
    end

    task load: :environment do
      puts 'Importing data to postgres'
      AfVenuesImporter.import
      puts 'Finished import'
    end
  end
end
