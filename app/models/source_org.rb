class SourceOrg < ApplicationRecord
  has_one :theatre
  has_many :af_venues
  has_many :af_venue_mappings
  validates :name, presence: true, uniqueness: true

  def self.import_af_source_orgs
    require 'csv'
    SourceOrg.destroy_all
    CSV.foreach(Rails.root.join('lib/af-source-orgs.csv'), headers: true) do |row|
      SourceOrg.create(id: row[0], name: row[1])
    end
  end
end
