class AfVenue < ApplicationRecord
  has_one :af_venue_mapping
  belongs_to :source_org
  validates :name, uniqueness: { scope: :source_org_id }
end
