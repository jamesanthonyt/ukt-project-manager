class CreateTheatres < ActiveRecord::Migration[5.2]
  def change
    create_table :theatres do |t|
      t.string :name
      t.string :management
      t.references :source_org, foreign_key: true
      t.boolean :include, default: true
      t.string :status
      t.text :notes

      t.timestamps
    end
  end
end
