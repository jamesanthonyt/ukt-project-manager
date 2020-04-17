class AfVenue < ApplicationRecord
  has_one :af_venue_mapping
  belongs_to :source_org
  validates :name, uniqueness: { scope: :source_org_id }

  require 'csv'

  def self.import_af_venues
    csv = CSV.read('lib/af-venues.csv', headers: true, encoding:'iso-8859-1:utf-8')
    csv.each do |row|
      next if venue_found?(row)

      AfVenue.create(
        id: "#{row['orgsrcid']}#{row['venue']}",
        name: row['venue'],
        source_org_id: row['orgsrcid']
      )
    end
    update_deleted_venues(csv)
  end

  def self.update_deleted_venues(csv)
    af_venues = AfVenue.all
    af_venues.each do |venue|
      if csv.find { |row| (row['orgsrcid'].to_s == venue.source_org_id.to_s && row['venue'].to_s == venue.name.to_s) } == nil
        venue.update!(deleted: true)
        venue.af_venue_mapping.destroy
      end
    end
  end

  def self.venue_found?(row)
    AfVenue.find_by(id: "#{row['orgsrcid']}#{row['venue']}")
  end
end
