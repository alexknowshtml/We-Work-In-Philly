class AddRegionToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :region, :string
  end

  def self.down
    remove_column :companies, :region
  end
end
