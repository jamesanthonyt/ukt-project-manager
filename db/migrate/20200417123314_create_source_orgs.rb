class CreateSourceOrgs < ActiveRecord::Migration[5.2]
  def change
    create_table :source_orgs do |t|
      t.string :name
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
