class Theatre < ApplicationRecord
  belongs_to :source_org, optional: true
  has_many :performance_spaces
  has_many :af_venues, through: :source_org
  validates :name, presence: true, uniqueness: true
  validates :source_org_id, uniqueness: { allow_blank: true }
  validates :management, inclusion: { in: [
    'Independent',
    'ATG',
    'SellaDoor',
    'HQ Theatres'
  ] }

  def self.import_theatres
    require 'csv'
    Theatre.destroy_all
    CSV.foreach(Rails.root.join('data/UKTTheatres.csv'), headers: true) do |row|
      Theatre.create(
        id: row[0],
        name: row[1],
        management: row[2],
        source_org_id: row[3],
        include: row[4],
        status: row[5],
        notes: row[6]
      )
    end
  end

  def self.to_csv
    require 'csv'
    attributes = %w{id name management source_org_id include  status notes created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |theatre|
        csv << attributes.map{ |attr| theatre.send(attr) }
      end
    end
  end
end
