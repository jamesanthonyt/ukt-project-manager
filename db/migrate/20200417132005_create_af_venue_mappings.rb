class CreateAfVenueMappings < ActiveRecord::Migration[5.2]
  def change
    create_table :af_venue_mappings do |t|
      t.references :af_venue, foreign_key: true, type: :string
      t.references :performance_space, foreign_key: true
      t.references :source_org, foreign_key: true

      t.timestamps
    end
  end
end
