class AddLatlongToCompany < ActiveRecord::Migration
  def self.up
    add_column :companies, :latitude, :float
    add_column :companies, :longitude, :float
  end

  def self.down
    remove_column :companies, :longitude
    remove_column :companies, :latitude
  end
end
