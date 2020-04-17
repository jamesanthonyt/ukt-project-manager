class CreateAfVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :af_venues, id: :string do |t|
      t.string :name
      t.references :source_org, foreign_key: true
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
