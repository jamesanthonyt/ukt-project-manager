class PerformanceSpace < ApplicationRecord
  belongs_to :theatre
  has_many :af_venue_mappings
  has_many :af_venues, through: :af_venue_mappings
  validates :name, presence: true, uniqueness: { scope: :theatre_id }
  validates :theatre_id, :grouping, :space_type, :capacity, :programme, presence: true
  validates :space_type, inclusion: { in: [
    'Main Auditorium',
    'Subsidiary Auditorium',
    'Concert Hall',
    'Cinema',
    'Cabaret Space',
    'Studio Space',
    'Other'
  ] }
  validates :capacity, numericality: { only_integer: true }
  validates :programme, inclusion: { in: [
    'Only produced in-house',
    'More produced in-house',
    'More presented/toured',
    'Only presented/toured'
  ] }
  validates :grouping, numericality: { only_integer: true }

  def self.import_performance_spaces
    require 'csv'
    PerformanceSpace.destroy_all
    CSV.foreach(Rails.root.join('lib/UKTPerformancespaces.csv'), headers: true) do |row|
      PerformanceSpace.create!(
        id: row[0],
        name: row[1],
        theatre_id: row[2],
        space_type: row[3],
        capacity: row[4],
        programme: row[5],
        grouping: row[6],
        include: row[7],
        notes: row[8]
      )
    end
  end
end
