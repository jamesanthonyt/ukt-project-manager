class ChangeAfVenuesIdToString < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :id, :string, null: false, unique: true
  end
end
