class StationCleanup < ActiveRecord::Migration[5.1]
  def change
    # Rename
    rename_column :station, :station_id, :id

    rename_column :station, :station_airport_airport_id, :airport_id
    rename_column :station, :station_owner_user_id, :user_id
    rename_column :station, :station_type, :category
    rename_column :station, :station_address_address_id, :address_id

    # Timestamps
    model_name = "station"

    timestamp_name = model_name + "_timestamp"
    add_column model_name.to_sym, :created_at, :datetime
    add_column model_name.to_sym, :updated_at, :datetime
    execute "UPDATE #{model_name} SET created_at = #{timestamp_name}"
    execute "UPDATE #{model_name} SET updated_at = #{timestamp_name}"
    remove_column model_name.to_sym, timestamp_name.to_sym, :updated_at

    # Tablename
    rename_table :station, :stations
  end
end
