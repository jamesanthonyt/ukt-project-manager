class SourceOrg < ApplicationRecord
  has_one :theatre
  has_many :af_venues
  has_many :af_venue_mappings
  validates :name, presence: true, uniqueness: true

  require 'csv'

  def self.import_af_source_orgs
    csv = CSV.read('data/af-source-orgs.csv', headers: true, encoding:'iso-8859-1:utf-8')
    csv.each do |row|
      next if source_org_found_available?(row)

      source_org_available!(row) if source_org_found_unavailable?(row)

      SourceOrg.create(
        id: row[0],
        name: row[1]
      )
    end
    source_org_unavailable!(csv)
  end

  def self.source_org_unavailable!(csv)
    source_orgs = SourceOrg.all
    source_orgs.each do |org|
      if csv.find { |row| (row[0].to_s == org.id.to_s) } == nil
        org.update!(deleted: true)
      end
    end
  end

  def self.source_org_found_available?(row)
    SourceOrg.find_by(id: row[0], deleted: false)
  end

  def self.source_org_found_unavailable?(row)
    SourceOrg.find_by(id: row[0], deleted: true)
  end

  def self.source_org_available!(row)
    source_org = SourceOrg.find_by(id: row[0], deleted: true)
    source_org.update!(deleted: false)
  end
end
