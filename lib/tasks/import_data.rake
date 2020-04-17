namespace :import do
  desc 'This imports AF and UKT data from CSVs'

  task :af_data do
    SourceOrg.import_af_source_orgs
    AfVenue.import_af_venues
  end

  task :ukt_data do
    Theatre.import_theatres
    PerformanceSpace.import_performance_spaces
    AfVenueMapping.import_af_venue_mappings
  end
end
