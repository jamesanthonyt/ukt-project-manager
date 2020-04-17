class CreatePerformanceSpaces < ActiveRecord::Migration[5.2]
  def change
    create_table :performance_spaces do |t|
      t.string :name
      t.references :theatre, foreign_key: true
      t.string :space_type
      t.integer :capacity
      t.string :programme
      t.string :grouping
      t.boolean :include, default: true
      t.text :notes

      t.timestamps
    end
  end
end
