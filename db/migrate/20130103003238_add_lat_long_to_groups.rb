class AddLatLongToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :latitude, :float
    add_column :groups, :longitude, :float
  end

  def self.down
    remove_column :groups, :longitude
    remove_column :groups, :latitude
  end
end
