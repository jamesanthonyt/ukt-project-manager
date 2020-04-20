class SourceOrg < ApplicationRecord
  has_one :theatre
  has_many :af_venues
  has_many :af_venue_mappings
  validates :name, presence: true, uniqueness: true
end
