class ChangeRevenueToString < ActiveRecord::Migration
  def self.up
    change_column :companies, :revenue, :string
  end

  def self.down
    change_column :companies, :revenue, :integer
  end
end
