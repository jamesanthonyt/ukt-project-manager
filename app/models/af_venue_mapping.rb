class AfVenueMapping < ApplicationRecord
  belongs_to :af_venue
  belongs_to :performance_space
  belongs_to :source_org
  validates :af_venue, :performance_space, presence: true
  validates :af_venue, uniqueness: { scope: :source_org }

  def self.import_af_venue_mappings
    require 'csv'
    AfVenueMapping.destroy_all
    CSV.foreach(Rails.root.join('lib/UKTVenueMappings.csv'), headers: true) do |row|
      AfVenueMapping.create(
        id: row[0],
        af_venue_id: row[1],
        performance_space_id: row[2],
        source_org_id: row[3]
      )
    end
  end
end
