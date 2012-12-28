class AddNumberOfEmployeesToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :number_of_employees, :integer
  end

  def self.down
    remove_column :companies, :number_of_employees
  end
end
