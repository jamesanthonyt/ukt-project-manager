class AfVenue < ApplicationRecord
  has_one :af_venue_mapping
  belongs_to :source_org
  validates :name, uniqueness: { scope: :source_org_id }

  require 'csv'

  def self.import_af_venues
    csv = CSV.read('lib/af-venues.csv', headers: true, encoding:'iso-8859-1:utf-8')
    csv.each do |row|
      next if venue_found_available?(row)

      venue_available!(row) if venue_found_unavailable?(row)

      AfVenue.create(
        id: "#{row['orgsrcid']}#{row['venue']}",
        name: row['venue'],
        source_org_id: row['orgsrcid']
      )
    end
    venue_unavailable!(csv)
  end

  def self.venue_unavailable!(csv)
    af_venues = AfVenue.all
    af_venues.each do |venue|
      if csv.find { |row| (row['orgsrcid'].to_s == venue.source_org_id.to_s && row['venue'].to_s == venue.name.to_s) } == nil
        venue.update!(deleted: true)
      end
    end
  end

  def self.venue_found_available?(row)
    AfVenue.find_by(id: "#{row['orgsrcid']}#{row['venue']}", deleted: false)
  end

  def self.venue_found_unavailable?(row)
    AfVenue.find_by(id: "#{row['orgsrcid']}#{row['venue']}", deleted: true)
  end

  def self.venue_available!(row)
    venue = AfVenue.find_by(id: "#{row['orgsrcid']}#{row['venue']}", deleted: true)
    venue.update!(deleted: false)
  end
end
