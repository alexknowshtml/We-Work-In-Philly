class AddRevenueToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :revenue, :integer
  end

  def self.down
    remove_column :companies, :revenue
  end
end
