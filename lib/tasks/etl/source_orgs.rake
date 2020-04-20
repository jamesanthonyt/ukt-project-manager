require 'source_orgs_importer'

namespace :etl do
  task :source_orgs => [
    'source_orgs:extract',
    'source_orgs:load'
  ]

  namespace :source_orgs do
    task extract: :environment do
      puts 'Downloading af-source-orgs.csv from S3'
      SourceOrgsImporter.extract
    end

    task load: :environment do
      puts 'Importing data to postgres'
      SourceOrgsImporter.import
      puts 'Finished import'
    end
  end
end
