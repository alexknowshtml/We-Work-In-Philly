class ChangeNumberOfEmployeesToString < ActiveRecord::Migration
  def self.up
    change_column :companies, :number_of_employees, :string
  end

  def self.down
    change_column :companies, :number_of_employees, :integer
  end
end
