class SourceOrg < ApplicationRecord
  has_one :theatre
  has_many :af_venues
  has_many :af_venue_mappings
  validates :name, presence: true, uniqueness: true

  require 'csv'

  def self.import_af_source_orgs
    csv = CSV.read('lib/af-source-orgs.csv', headers: true, encoding:'iso-8859-1:utf-8')
    csv.each do |row|
      next if source_org_found?(row)

      SourceOrg.create(
        id: row[0],
        name: row[1]
      )
    end
  end

  def self.source_org_found?(row)
    SourceOrg.find_by(id: row[0])
  end
end
